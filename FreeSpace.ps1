<#
With this script, we check the free disk (DeviceID) space on each machine matching the filter by OS having "Server" in name, and output the information in GB and with 3 characters in a decimal fraction (F3)
Note: Get-WmiObject is deprecated in PowerShell Core. DriveType 5 is a CDROM. Lines 7 and 8 both work, choose whatever you like more
#>
$Computers = Get-ADComputer -filter {operatingsystem -like "*server*" -and enabled -eq $true} | sort name
$Table = foreach ($computer in $computers) {
Get-WmiObject -Computername $computer.name -Class Win32_LogicalDisk | ? {$_.DriveType -ne 5} | Select @{n="Server"; e={$computer.name}},DeviceID,@{n="Size (GB)";e={($_.Size/1GB).ToString('F3')}},@{n="Free (GB)";e={($_.FreeSpace/1GB).ToString('F3')}}, @{n="% Free"; e={(($_.FreeSpace/$_.Size)*100).ToString('F2')}}
}
$Table | FT