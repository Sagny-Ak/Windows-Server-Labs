# Organizational Units & Groups

## OU Structure

```
vitaltech.local
└── vitalTech-Company
    ├── Direction
    │   ├── Utilisateurs
    │   └── Groupe
    ├── Informatique
    │   ├── Utilisateurs
    │   └── Groupe
    ├── Comptabilite
    │   ├── Utilisateurs
    │   └── Groupe
    ├── Commercial
    │   ├── Utilisateurs
    │   └── Groupe
    └── Groupes_DL
        ├── DL_Direction
        ├── DL_Informatique
        ├── DL_Comptabilite
        └── DL_Commercial
```

> **Why sub-OUs per department?**
> GPOs are linked at OU level. Separating Users and Groups inside
> each department OU allows precise GPO targeting per department.

## AGDLP Group Model

```
User Account (A)
    → Global Group (G) — GG_Department
        → Domain Local Group (DL) — DL_Department
            → NTFS Permission (P) on Share
```

| Group | Type | Scope | Location |
|---|---|---|---|
| GG_Direction | Security | Global | OU=Direction |
| GG_Informatique | Security | Global | OU=Informatique |
| GG_Comptabilite | Security | Global | OU=Comptabilite |
| GG_Commercial | Security | Global | OU=Commercial |
| DL_Direction | Security | Domain Local | OU=Groupes_DL |
| DL_Informatique | Security | Domain Local | OU=Groupes_DL |
| DL_Comptabilite | Security | Domain Local | OU=Groupes_DL |
| DL_Commercial | Security | Domain Local | OU=Groupes_DL |

## Why AGDLP?

- **Global Groups** contain user accounts from one domain
- **Domain Local Groups** are assigned permissions on resources
- Nesting GG inside DL = clean separation between identity and access
- Scalable to multi-domain environments (AGUDLP)
