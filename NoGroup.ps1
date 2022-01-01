<#
This is a script to check the users that are not a part of a group with a matching criteria (specified on Line 12).
Will return a list of the users, the output could be expanded if needed. Here we are checking by the attribute (employeeID, but it could be changed of course)

Related post: https://dykhl.in/post/5
#>

$results = @()
$users = Get-ADUser -Properties memberof,employeeID -Filter {enabled -eq $True} | ? {$_.employeeID -eq "E3"}
foreach ($user in $users) {
    $groups = $user.memberof -join ';'
    $results += New-Object psObject -Property @{'User'=$user.name;'Groups'= $groups}
    }
$results | Where-Object { $_.groups -notmatch 'PasswordPolicyUsers' } | Select-Object User | Sort-Object User