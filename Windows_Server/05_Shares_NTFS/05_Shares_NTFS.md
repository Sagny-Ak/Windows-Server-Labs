# File Shares & NTFS Permissions

## Share Structure

All shares stored under `C:\Users\Administrateur\Desktop\Partage\`

| Share Name | Physical Path | Visible |
|---|---|---|
| `Direction$` | `...\Partage\Direction` | Hidden |
| `Informatique$` | `...\Partage\Informatique` | Hidden |
| `Comptabilite$` | `...\Partage\Comptabilite` | Hidden |
| `Commercial$` | `...\Partage\Commercial` | Hidden |

> **Why hidden shares (`$`)?**
> The `$` suffix hides the share from network browsing.
> Users access via mapped drive only — they never need to browse `\\SRV-VT01\`.
> This reduces attack surface and enforces access control.

## PowerShell — Create Shares

```powershell
New-SmbShare -Name "Direction$" -Path "C:\Users\Administrateur\Desktop\Partage\Direction"
New-SmbShare -Name "Informatique$" -Path "C:\Users\Administrateur\Desktop\Partage\Informatique"
New-SmbShare -Name "Comptabilite$" -Path "C:\Users\Administrateur\Desktop\Partage\Comptabilite"
New-SmbShare -Name "Commercial$" -Path "C:\Users\Administrateur\Desktop\Partage\Commercial"
```

## Two-Layer Permission Model

### Layer 1 — Share Permissions (SMB)
| Group | Permission |
|---|---|
| DL_Direction | Full Control |
| DL_Informatique | Full Control |
| DL_Comptabilite | Full Control |
| DL_Commercial | Full Control |

### Layer 2 — NTFS Permissions
| Group | Permission |
|---|---|
| DL_Direction | Modify |
| DL_Informatique | Modify |
| DL_Comptabilite | Read & Execute |
| DL_Commercial | Read & Execute |
| SYSTEM | Full Control |
| Administrators | Full Control |

> **Key principle:** Share permissions are the outer door,
> NTFS permissions are the inner lock.
> The most restrictive permission wins when accessing over the network.

## Verify Shares

```powershell
Get-SmbShare | Select-Object Name, Path
```
