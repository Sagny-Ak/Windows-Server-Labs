# Active Directory Domain Services — Setup

## Why AD DS?

VitalTech SARL needed a centralized authentication system.
Without AD, each PC manages its own users locally — impossible to scale with 25 employees across 4 departments.

AD DS provides:
- One domain (`vitaltech.local`) for all users
- Centralized authentication via Kerberos
- Group Policy enforcement across all machines
- Centralized access control for file shares

## Environment

| Setting | Value |
|---|---|
| Server name | SRV-VT01 |
| Domain | vitaltech.local |
| Internal IP | 172.16.10.1/24 |
| OS | Windows Server 2022 |
| Virtualization | KVM/QEMU |

## Installation Steps

1. Opened **Server Manager** → Add Roles and Features
2. Selected **Active Directory Domain Services**
3. Promoted server to Domain Controller
4. Created new forest: `vitaltech.local`
5. Set DNS to point to internal IP `172.16.10.1`
6. Restarted server — domain controller active

## Result

- SRV-VT01 promoted as Domain Controller ✅
- Domain `vitaltech.local` created ✅
- DNS restricted to internal interface only ✅
- DHCP authorized in Active Directory ✅
