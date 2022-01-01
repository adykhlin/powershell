<#
We check for the password expiry date for the accounts. Function in the end could be used in PowerShell $Profile to make the check easier. You can change the function name to something else if you want.
Related post: https://dykhl.in/post/8
#>

$user = Read-Host -Prompt "Username or part of it"

Get-ADUser -filter "samaccountname -like '*$user*' -and enabled -eq 'True' -and PasswordNeverExpires -eq 'False'" -Properties msDS-UserPasswordExpiryTimeComputed | Select-Object Name,sam*,@{n="Expiry Date";e={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}} | Sort-Object "Expiry Date"


<#
Function to add to $profile

function Get-PasswordExpiryDate {
  param(
        [Parameter(Mandatory)]
        [string]$user
    )
Get-ADUser -filter "samaccountname -like '*$user*' -and enabled -eq 'True' -and PasswordNeverExpires -eq 'False'" -Properties msDS-UserPasswordExpiryTimeComputed | Select-Object Name,sam*,@{n="Expiry Date";e={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}} | Sort-Object "Expiry Date"
}
#>