. ./KeepassXCEnv.sh

Set_ConfAsHardLink() {
    hostPath=$1
    cloudPath=$2
    if [ ! -f $hostPath ];
    then
	    ln $cloudPath $hostPath
    else
	hostInode=$(ls -i $hostPath | awk '{print $1 }')
	cloudInode=$(ls -i $cloudPath | awk '{print $1 }')

	if [ $hostInode -eq $cloudInode ];
	then
	    rm $hostPath
	    ln $cloudPath $hostPath
	fi
    fi
}

Set_ConfAsHardLink $host_localconf_path $localconf_path
Set_ConfAsHardLink "$HOME/.config/keepassxc/keepassxc.ini" $conf_path

mkdir $HOME/MyKeepassXC
cp KeepassXCEnv.sh $HOME/MyKeepassXC

cat <<END > $HOME/MyKeepassXC/StartCustomKeepass.sh
#!/bin/sh

. $HOME/MyKeepassXC/KeepassXCEnv.sh

echo \$(\$get_master_key_cmd) | keepassxc --pw-stdin --keyfile \$keyfile_path \$dbfile_path --localconfig \$localconf_path --config \$conf_path
END

# I cant use keyring to retrieve pw in systemd, i dont know why
mkdir -p $HOME/.config/autostart
cat <<END > $HOME/.config/autostart/StartCustomKeepass.sh.desktop
[Desktop Entry]
Type=Application
Exec=$HOME/MyKeepassXC/StartCustomKeepass.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=keepassxc
Name=keepassxc
Comment[en_US]=
Comment=
END

chmod a+x MyKeepassXC/StartCustomKeepass.sh