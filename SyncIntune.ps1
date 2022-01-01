<#
Specify the OS for the devices you want to Sync (line 11):
Windows: $Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem, 'Windows')"
iOS/ipadOS: $Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem, 'iOS')"
Android: $Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem, 'Android')"
macOS: $Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem, 'macOS')"
All devices: $Devices = Get-IntuneManagedDevice


Related post: https://dykhl.in/post/6
#>
Connect-MSGraph
$Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem, 'Windows')"
Foreach ($Device in $Devices) {
Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $Device.managedDeviceId
Write-Host "Sending Sync request to device $($Device.deviceName)"
}