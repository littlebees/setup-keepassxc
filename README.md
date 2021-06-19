# Setup keepassxc on linux

## How to use
1. Run RegJob.sh, which will do
    * HardLink keepassxc config & local config
        * Assume keepassxc is install by snap
    * Copy related scripts into `$home/MyKeepassXC`
    * Make `StartCustomKeepass.sh` to run at boot on
        * this uses gnome's autostart
3. StartCustomKeepass.sh will do
    * Get master key from secret-tool
    * Start keepassxc with given db, keyfile, config and localconfig