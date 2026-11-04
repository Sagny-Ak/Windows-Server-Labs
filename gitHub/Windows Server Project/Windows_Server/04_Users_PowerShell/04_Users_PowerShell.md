# User Accounts — PowerShell Management

## Users Created

| Name | Login | Department |
|---|---|---|
| Koffi Mensah | kmensah | Direction |
| Kokou Komlan | k.komlan | Direction |
| Tony Stark | tstark | Informatique |
| Jack Bauer | jbauer | Informatique |
| Kuame Nkrumer | knkrumer | Informatique |
| Felicity Brian | fbrian | Comptabilite |
| Oliver Queen | oqueen | Commercial |

## PowerShell Commands Used

### Create a user
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

### Add user to group
```powershell
Add-ADGroupMember -Identity "GG_Informatique" -Members "tstark"
```

### Verify users
```powershell
Get-ADUser -Filter * | Select-Object Name, SamAccountName | Format-Table -AutoSize
```

### Verify group members
```powershell
Get-ADGroupMember -Identity "GG_Informatique"
```

## Issue Encountered

**UPN not unique error** on Oliver Queen:
- Cause: typo `oqueen@altech.local` instead of `oqueen@vitaltech.local`
- Fix: deleted user and recreated with correct UPN

```powershell
Remove-ADUser -Identity "oqueen" -Confirm:$false
# Then recreate with correct UPN
```
