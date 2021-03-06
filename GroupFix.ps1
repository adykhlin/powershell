<#
This script is for removing a user from a group B if they are members of group A. You can change the names of course to fulfill your needs. 
Don't forget to change on line 8,9 and 14. Identities "Group 1" and "Group 2" are used for the generalization 
And it will be more convenient to use samaccountname as a property.

Related post: https://dykhl.in/post/7
#>
$groupA = Get-ADGroupMember -Identity "Group 1" -Recursive | Select-Object -ExpandProperty samaccountname
$groupB = Get-ADGroupMember -Identity "Group 2" -Recursive | Select-Object -ExpandProperty samaccountname

foreach ($user in $groupA) {
If ($groupB -contains $user) {
      Write-Host "$user is a member of both groups, removing from the second one"
      Remove-ADGroupMember -Identity "Group 2" -Member $user -Confirm:$false
 } 
}