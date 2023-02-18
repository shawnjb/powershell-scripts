# Enable the Windows Sandbox feature
# (c) 2023, Shawn J. Bragdon

if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator") )
{
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Containers\CmService\PolicyName'
$regItem = 'Default'
if ( !(Test-Path $regPath\$regItem) )
{
    New-Item -Path "$regPath\\" -Name $regItem -Force | Out-Null
    Set-ItemProperty -Path "$regPath\$regItem" -Name '(Default)' -Value "BlockNonWindowsApp" -Type String -Force | Out-Null
} else {
    Set-ItemProperty -Path "$regPath\$regItem" -Name '(Default)' -Value "BlockNonWindowsApp" -Type String -Force | Out-Null
}
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
Start-Process "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -ArgumentList "Start-Sandbox" -Verb RunAs
