# Setup keepassxc on windows

## How to use
1. Open powershell as Administrator
2. Run RegJob.ps1, which will do
    * HardLink keepassxc config & local config
    * Copy related scripts into `$home/MyKeepassXC`
    * Make `StartCustomKeepass.ps1` to run at boot on
3. StartCustomKeepass.ps1 will do
    * Get master key from Windows Credential Manager
    * Start keepassxc with given db, keyfile, config and localconfig