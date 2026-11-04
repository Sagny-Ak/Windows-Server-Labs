# 🖥️ VitalTech SARL — Windows Server 2022 Active Directory Lab

> A complete enterprise-grade Active Directory infrastructure built from scratch on Windows Server 2022, simulating a real IT services company based in Lomé, Togo.

---

## 🏢 Company Context

**VitalTech SARL** is a fictional IT services company based in Lomé, Togo, with 25 employees across 4 departments:

| Department | Employees | Role |
|---|---|---|
| Direction | 2 | Executive management |
| Informatique | 8 | IT & Systems |
| Comptabilité | 5 | Accounting |
| Commercial | 10 | Sales |

---

## 🌐 Infrastructure Overview

| Component | Value |
|---|---|
| Domain | `vitaltech.local` |
| Domain Controller | `SRV-VT01` |
| Internal IP | `172.16.10.1/24` |
| DHCP Range | `172.16.10.100 – 172.16.10.200` |
| Virtualization | KVM/QEMU via PNETLab |
| OS | Windows Server 2022 |

### Network Architecture
```
Internet
    │
    ├── NAT Interface (192.168.122.x) ── KVM Host
    │
    └── Internal Interface (172.16.10.1/24)
            │
            ├── SRV-VT01 (DC + DNS + DHCP)
            └── Client-PC (Windows 10 — domain joined)
```

---

## 📁 Active Directory Structure

```
vitaltech.local
└── vitalTech-Company
    ├── Direction
    │   ├── Utilisateurs
    │   └── Groupe (GG_Direction)
    ├── Informatique
    │   ├── Utilisateurs
    │   └── Groupe (GG_Informatique)
    ├── Comptabilite
    │   ├── Utilisateurs
    │   └── Groupe (GG_Comptabilite)
    ├── Commercial
    │   ├── Utilisateurs
    │   └── Groupe (GG_Commercial)
    └── Groupes_DL
        ├── DL_Direction
        ├── DL_Informatique
        ├── DL_Comptabilite
        └── DL_Commercial
```

### AGDLP Group Model

```
User Account
    → Global Group (GG_Department)
        → Domain Local Group (DL_Department)
            → NTFS Permission on Share
```

---

## 👥 User Management (PowerShell)

Users were created via PowerShell using `New-ADUser`:

```powershell
New-ADUser `
  -GivenName "Tony" `
  -Surname "Stark" `
  -Name "Tony Stark" `
  -SamAccountName "tstark" `
  -UserPrincipalName "tstark@vitaltech.local" `
  -Path "OU=Utilisateurs,OU=Informatique,OU=vitalTech-Company,DC=vitaltech,DC=local" `
  -AccountPassword (ConvertTo-SecureString "<TempPassword>" -AsPlainText -Force) `
  -Enabled $true
```

---

## 📂 File Shares & NTFS Permissions

Hidden SMB shares (`$`) were created for each department:

| Share | Path | Access Group |
|---|---|---|
| `Direction$` | `C:\Partage\Direction` | DL_Direction |
| `Informatique$` | `C:\Partage\Informatique` | DL_Informatique |
| `Comptabilite$` | `C:\Partage\Comptabilite` | DL_Comptabilite |
| `Commercial$` | `C:\Partage\Commercial` | DL_Commercial |

**Two-layer permission model:**
- **Share level** → Full Control to Domain Local Group
- **NTFS level** → Granular permissions per group (Read / Modify)

---

## 🛡️ Group Policy Objects (GPO)

### GPO_MotDePasse — Password Policy
| Setting | Value |
|---|---|
| Minimum length | 12 characters |
| Complexity | Enabled |
| Maximum age | 90 days |
| Password history | 5 passwords |
| Reversible encryption | Disabled |

### GPO_Verrouillage — Account Lockout
| Setting | Value |
|---|---|
| Lockout threshold | 5 failed attempts |
| Lockout duration | 10 minutes |
| Reset counter after | 10 minutes |
| Admin account lockout | Enabled |

### GPO_Audit — Security Auditing
| Event | Setting |
|---|---|
| Logon events | Success, Failure |
| Account management | Success, Failure |
| Directory service access | Success, Failure |
| Object access | Success, Failure |
| Policy change | Success, Failure |
| Privilege use | Success, Failure |

### GPO_Bureaux — Desktop Policy
- Corporate wallpaper deployed via `\\SRV-VT01\NETLOGON\`
- Screen lock after 10 minutes of inactivity
- Password-protected screensaver

### GPO_Restrictions — User Restrictions (Commercial & Comptabilité only)
- Command Prompt (CMD) — Disabled
- Registry Editor — Disabled
- Control Panel & Settings — Disabled

### GPO_Lecteurs — Drive Mapping (per department)
| GPO | Share | Drive |
|---|---|---|
| GPO_Lecteur_Direction | `\\SRV-VT01\Direction$` | B: |
| GPO_Lecteur_Informatique | `\\SRV-VT01\Informatique$` | Y: |
| GPO_Lecteur_Comptabilite | `\\SRV-VT01\Comptabilite$` | X: |
| GPO_Lecteur_Commercial | `\\SRV-VT01\Commercial$` | W: |

---

## ✅ Validation Tests

| Test | Command | Result |
|---|---|---|
| Domain membership | `systeminfo` | ✅ VITALTECH domain |
| DNS resolution | `nslookup vitaltech.local` | ✅ 172.16.10.1 |
| Server ping | `ping SRV-VT01.vitaltech.local` | ✅ Reply |
| GPO applied | `gpresult /r` | ✅ All GPOs listed |
| Drive mapping | `net use` | ✅ Department drive visible |

---

## ⚠️ Issues Encountered & Solutions

| Issue | Cause | Solution |
|---|---|---|
| SMB + NTFS permission conflict | Both levels misconfigured simultaneously | Separated configuration: Full Control on Share, granular on NTFS |
| UPN not unique (Oliver Queen) | Typo: `altech.local` instead of `vitaltech.local` | Deleted and recreated user with correct UPN |
| PowerShell `Substring` null error | Special characters in ISE | Replaced with `$prenom[0]` syntax |
| MDT/WDS deployment impossible | Insufficient disk space + Microsoft retired MDT | Deferred to Windows Server Datacenter build |

---

## 🛠️ Tech Stack

![Windows Server](https://img.shields.io/badge/Windows_Server-2022-0078D6?style=flat&logo=windows)
![Active Directory](https://img.shields.io/badge/Active_Directory-AGDLP-0078D6?style=flat&logo=microsoft)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1-5391FE?style=flat&logo=powershell)
![KVM](https://img.shields.io/badge/KVM%2FQEMU-Virtualization-orange?style=flat)

- Windows Server 2022
- Active Directory Domain Services
- DNS & DHCP
- PowerShell (AD Module)
- Group Policy Management
- SMB File Shares + NTFS
- KVM/QEMU (PNETLab)

---

## 🚀 What's Next

> *What if we pushed further? Windows Server Datacenter, unlimited virtualization, automated MDT/WDS deployment...*

- [ ] Windows Server Datacenter — Hyper-V unlimited VMs
- [ ] MDT + WDS — Zero-touch OS deployment
- [ ] AD CS — Internal Certificate Authority
- [ ] NPS/RADIUS — Network authentication
- [ ] Week 2 — Linux Systems Administration

---

## 👤 Author

**Kossi Didier Vital AYI**
IT Specialist | Windows & Linux Server Administration | Cybersecurity
📍 Lomé, Togo
🔗 [LinkedIn](https://www.linkedin.com/in/vital-ayi)

---

*Built as part of a structured 5-week IT training plan covering Windows Server, Linux, Cybersecurity, and Cisco Networking.*
