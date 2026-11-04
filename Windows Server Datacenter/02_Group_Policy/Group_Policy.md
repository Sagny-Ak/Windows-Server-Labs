# Group Policy

Group Policy enforces the security baseline on every machine without manual configuration. Each GPO has one clear purpose and a precise scope, and each one is documented with its configuration and the tests that prove it.

## Design principles

- **One purpose per GPO**: a policy that does one thing is easy to understand, test and withdraw.
- **Precise scope**: policies are linked to the OU that needs them, and role policies are filtered to a single computer account.
- **Domain Controllers excluded** from the server policies, so Active Directory ports are never blocked by mistake.
- **Consistent naming**: `GPO - <Function>` for policies and `GPP - <Function>` for Group Policy Preferences.
- **Tested one by one**: each policy is followed by its verification, including a negative test when one exists.

## GPO catalog

| GPO | Category | Linked to | Details |
|---|---|---|---|
| GPO - Firewall - Base | Network security | `OU_Server` | [Network security](01_Network_Security.md) |
| GPO - Firewall - File Server | Network security | `OU_Server` (`File-SRV`) | [Network security](01_Network_Security.md) |
| GPO - Firewall - IIS | Network security | `OU_Server` (`IIS-SRV`) | [Network security](01_Network_Security.md) |
| GPO - Firewall - CA | Network security | `OU_Server` (`CA-SRV`) | [Network security](01_Network_Security.md) |
| GPO - Firewall - WSUS | Network security | `OU_Server` (`WSUS-SRV`) | [Network security](01_Network_Security.md) |
| GPO - Server Baseline - Remote Access | Access control | `OU_Server` | [Access control](02_Access_Control.md) |
| GPP - Local Administrators | Access control | `Workstations` | [Access control](02_Access_Control.md) |
| GPO - Advanced Audit Policy | Audit | `OU_Server`, Domain Controllers | [Audit](03_Audit.md) |
| GPO - USB Restriction - Finance | Data protection | `OU_Finance` | [Data protection](04_Data_Protection.md) |
| GPO - USB Restriction - HR | Data protection | `OU_HR` | [Data protection](04_Data_Protection.md) |
| GPO - Drive Mapping | User environment | `Users` | [User environment](05_User_Environment.md) |
| GPO - Universal Wallpaper | User environment | `Workstations` | [User environment](05_User_Environment.md) |
| PKI - Trusted Root CA | Trust | Domain | [Trust](06_Trust.md) |

## Reading order

1. [Network security](01_Network_Security.md)
2. [Access control](02_Access_Control.md)
3. [Audit](03_Audit.md)
4. [Data protection](04_Data_Protection.md)
5. [User environment](05_User_Environment.md)
6. [Trust](06_Trust.md)
