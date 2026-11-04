# ========================================
# VitalTech SARL — AD User Creation Script
# Author: Kossi Didier Vital AYI
# Domain: vitaltech.local
# ========================================

# Usage: Run as Administrator on SRV-VT01
# Example: New-ADUser -GivenName "Tony" -Surname "Stark" ...

$domaine = "DC=vitaltech,DC=local"
$baseOU = "OU=vitalTech-Company,$domaine"

# ----------------------------------------
# Function: Create a single AD user
# ----------------------------------------
function New-VTUser {
    param (
        [string]$Prenom,
        [string]$Nom,
        [string]$Departement,
        [string]$Poste
    )

    $login = ($Prenom.Substring(0,1) + $Nom).ToLower()
    $ouPath = "OU=Utilisateurs,OU=$Departement,$baseOU"
    $motDePasse = ConvertTo-SecureString "<TempPassword>" -AsPlainText -Force

    New-ADUser `
        -GivenName       $Prenom `
        -Surname         $Nom `
        -Name            "$Prenom $Nom" `
        -SamAccountName  $login `
        -UserPrincipalName "$login@vitaltech.local" `
        -Path            $ouPath `
        -Title           $Poste `
        -AccountPassword $motDePasse `
        -Enabled         $true `
        -PasswordNeverExpires $false

    Write-Host "User created: $login -> $Departement" -ForegroundColor Cyan

    # Add to department Global Group
    $gg = "GG_$Departement"
    Add-ADGroupMember -Identity $gg -Members $login
    Write-Host "$login added to $gg" -ForegroundColor Green
}

# ----------------------------------------
# Create VitalTech users
# ----------------------------------------

New-VTUser -Prenom "Koffi"    -Nom "Mensah"   -Departement "Direction"    -Poste "Directeur General"
New-VTUser -Prenom "Kokou"    -Nom "Komlan"   -Departement "Direction"    -Poste "Assistante DG"
New-VTUser -Prenom "Tony"     -Nom "Stark"    -Departement "Informatique" -Poste "Admin Systemes"
New-VTUser -Prenom "Jack"     -Nom "Bauer"    -Departement "Informatique" -Poste "Technicien Reseau"
New-VTUser -Prenom "Kuame"    -Nom "Nkrumer"  -Departement "Informatique" -Poste "Developpeur"
New-VTUser -Prenom "Felicity" -Nom "Brian"    -Departement "Comptabilite" -Poste "Comptable Chef"
New-VTUser -Prenom "Oliver"   -Nom "Queen"    -Departement "Commercial"   -Poste "Commercial Senior"

# ----------------------------------------
# Nest Global Groups into Domain Local Groups (AGDLP)
# ----------------------------------------

Add-ADGroupMember -Identity "DL_Direction"    -Members "GG_Direction"
Add-ADGroupMember -Identity "DL_Informatique" -Members "GG_Informatique"
Add-ADGroupMember -Identity "DL_Comptabilite" -Members "GG_Comptabilite"
Add-ADGroupMember -Identity "DL_Commercial"   -Members "GG_Commercial"

Write-Host "`nAGDLP nesting complete!" -ForegroundColor Yellow

# ----------------------------------------
# Verify
# ----------------------------------------

Write-Host "`n--- All AD Users ---" -ForegroundColor White
Get-ADUser -Filter * | Select-Object Name, SamAccountName | Format-Table -AutoSize
