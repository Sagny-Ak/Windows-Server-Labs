# Group Policy Objects (GPO)

## GPO Overview

| GPO Name | Linked To | Purpose |
|---|---|---|
| GPO_MotDePasse | vitalTech-Company | Password policy |
| GPO_account_lock_up | vitalTech-Company | Account lockout |
| GPO_Audit | vitalTech-Company | Security auditing |
| GPO_fond_ecran | vitalTech-Company | Corporate wallpaper + screen lock |
| GPO_Restrictions | OU=Commercial + OU=Comptabilite | User restrictions |
| GPO_Lecteur_Direction | OU=Direction | Drive mapping B: |
| GPO_Lecteur_Informatique | OU=Informatique | Drive mapping Y: |
| GPO_Lecteur_Comptabilite | OU=Comptabilite | Drive mapping X: |
| GPO_Lecteur_Commercial | OU=Commercial | Drive mapping W: |

---

## GPO_MotDePasse — Password Policy

`Computer Configuration > Windows Settings > Security Settings > Account Policies > Password Policy`

| Setting | Value |
|---|---|
| Minimum password length | 12 characters |
| Password complexity | Enabled |
| Maximum password age | 90 days |
| Minimum password age | 5 days |
| Enforce password history | 5 passwords |
| Store password with reversible encryption | Disabled |

---

## GPO_account_lock_up — Account Lockout

`Computer Configuration > Windows Settings > Security Settings > Account Policies > Account Lockout Policy`

| Setting | Value |
|---|---|
| Account lockout threshold | 5 failed attempts |
| Account lockout duration | 10 minutes |
| Reset lockout counter after | 10 minutes |
| Administrator account lockout | Enabled |

---

## GPO_Audit — Security Auditing

`Computer Configuration > Windows Settings > Security Settings > Local Policies > Audit Policy`

| Event | Setting |
|---|---|
| Audit account logon events | Success, Failure |
| Audit account management | Success, Failure |
| Audit directory service access | Success, Failure |
| Audit logon events | Failure |
| Audit object access | Success, Failure |
| Audit policy change | Success |
| Audit privilege use | Success, Failure |
| Audit process tracking | Success, Failure |
| Audit system events | Success, Failure |

---

## GPO_fond_ecran — Desktop Policy

`User Configuration > Administrative Templates > Desktop > Desktop`

- Corporate wallpaper: `\\SRV-VT01\NETLOGON\vitaltech_wallpaper.png`
- Wallpaper style: Fill

`User Configuration > Administrative Templates > Control Panel > Personalization`

| Setting | Value |
|---|---|
| Enable screen saver | Enabled |
| Screen saver timeout | 600 seconds (10 min) |
| Password protect the screen saver | Enabled |

---

## GPO_Restrictions — User Restrictions

Applied to: **Commercial** and **Comptabilité** departments only.

`User Configuration > Administrative Templates > System`

| Setting | Value |
|---|---|
| Prevent access to the command prompt | Enabled |
| Prevent access to registry editing tools | Enabled |

`User Configuration > Administrative Templates > Control Panel`

| Setting | Value |
|---|---|
| Prohibit access to Control Panel and PC Settings | Enabled |

---

## GPO_Lecteurs — Drive Mapping

`User Configuration > Preferences > Windows Settings > Drive Maps`

| GPO | Action | Path | Drive Letter |
|---|---|---|---|
| GPO_Lecteur_Direction | Create | `\\SRV-VT01\Direction$` | B: |
| GPO_Lecteur_Informatique | Create | `\\SRV-VT01\Informatique$` | Y: |
| GPO_Lecteur_Comptabilite | Create | `\\SRV-VT01\Comptabilite$` | X: |
| GPO_Lecteur_Commercial | Create | `\\SRV-VT01\Commercial$` | W: |
