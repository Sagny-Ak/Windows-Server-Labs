# File Server Security

Hardening of a Windows Server file server (`File-SRV`) in the `VitalTech.local` domain. The lab covers department-based access with AGDLP, access-based enumeration, auditing of file access, quotas, file screening, recovery options and encryption at rest. Every control is followed by documented tests with screenshots.

## Contents

| Folder | Topic |
|---|---|
| [01_Architecture](01_Architecture/Architecture.md) | Server, volume, shares, AGDLP model and naming |
| [02_Share_Permissions](02_Share_Permissions/Share_Permissions.md) | NTFS and share permissions, access-based enumeration, drive mapping |
| [03_Server_Hardening](03_Server_Hardening/Server_Hardening.md) | GPOs applied to the file server, SMB settings |
| [04_Audit_Logging](04_Audit_Logging/Audit_Logging.md) | Audit policy, SACL, file access events |
| [05_Storage_Protection](05_Storage_Protection/Storage_Protection.md) | Quotas, file screening, Shadow Copies, backup, BitLocker |

## Threats covered

| Threat | Controls | Document |
|---|---|---|
| A user reads or changes another department's files | AGDLP, NTFS permissions, access-based enumeration | 02 |
| A privileged account is exposed on the file server | Tier restrictions, dedicated administration group | 03 |
| A deletion or change cannot be traced | Audit policy and SACL, events 4663 and 4656 | 04 |
| A department fills the disk | FSRM hard quotas | 05 |
| Executable or script files are stored in shares | FSRM file screening | 05 |
| A file is deleted or overwritten by mistake | Shadow Copies | 05 |
| The data disk fails | Windows Server Backup | 05 |
| The disk or the VM image is stolen | BitLocker on `S:` | 05 |

## Known limitations

- SMB encryption is not enabled on the shares.
- BitLocker auto-unlock is disabled: `S:` stays locked after a reboot until an administrator unlocks it.
- Shadow Copies are stored on the same volume as the data, so they do not replace the backup.
- Each folder has one Domain Local group with read and write rights. A read-only group would be needed for read-only access.
- DFS is out of scope: the lab has a single file server.
