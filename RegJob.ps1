. .\KeepassXCEnv.ps1

$ErrorActionPreference = 'Stop'

function Set-ConfAsHardLink {
    param (
        [string]$HostPath,
        [string]$CloudPath
    )
    if(!(Test-Path -Path $HostPath)) {
        New-Item -ItemType HardLink -Path $HostPath -Value $CloudPath
    } elseif(!(Get-ItemProperty $HostPath).LinkType -eq "HardLink") {
        Remove-Item $HostPath
        New-Item -ItemType HardLink -Path $HostPath -Value $CloudPath
    }
}

Install-Module -Name CredentialManager -Scope CurrentUser

Set-ConfAsHardLink -HostPath "$home\AppData\Local\KeePassXC\keepassxc.ini" -CloudPath $localconf_path
Set-ConfAsHardLink -HostPath "$home\AppData\Roaming\KeePassXC\keepassxc.ini" -CloudPath $conf_path

New-Item -Path $home\MyKeepassXC -ItemType directory
Copy-Item -Path KeepassXCEnv.ps1 -Destination $home\MyKeepassXC
Copy-Item -Path StartCustomKeepass.ps1 -Destination $home\MyKeepassXC

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\mykeepassxc.lnk")
$Shortcut.TargetPath = "C:\Windows\System32\cmd.exe"
$Shortcut.Arguments = "/c start /min `"`" powershell -WindowStyle Hidden -Command `"$home\MyKeepassXC\StartCustomKeepass.ps1`""
$Shortcut.IconLocation = "C:\Program Files\KeePassXC\KeePassXC.exe"
$Shortcut.save()