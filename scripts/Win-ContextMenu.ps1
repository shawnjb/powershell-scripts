# Interchangable Right-click Shell Menu
# (c) 2023, Shawn J. Bragdon

$regPath = 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}'
$regItem = 'InprocServer32'

if ( !(Test-Path $regPath\$regItem) )
{
    New-Item -Path "$regPath\\" -Name $regItem -Force | Out-Null
    Set-ItemProperty -Path "$regPath\$regItem" -Name '(Default)' -Value $null -Type String -Force | Out-Null
    taskkill.exe /f /im explorer.exe
    Start-Process explorer.exe
} else {
    Remove-Item -Path "$regPath\$regItem" -Force | Out-Null
    taskkill.exe /f /im explorer.exe
    Start-Process explorer.exe
}
