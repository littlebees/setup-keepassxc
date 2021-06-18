. $home\MyKeepassXC\KeepassXCEnv.ps1

# painful, i cant use $cmd as command!?
# so i have to expand $cmd into full path
# $keepassxc="$Env:Programfiles\KeePassXC\KeePassXC.exe" -replace ' ','` '

$pw=Get-StoredCredential -Target $masterKeyTargetName
$pw.GetNetworkCredential().password | C:\Program` Files\KeePassXC\KeePassXC.exe --pw-stdin --keyfile $keyfile_path $dbfile_path --localconfig $localconf_path --config $conf_path