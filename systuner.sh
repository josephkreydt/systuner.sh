#!/bin/bash

echo "Welcome, noble hacker! Your Ubuntu system will now be tuned."

# update and upgradeapt 
#sudo apt update && sudo apt upgrade

# install rclone if it's not installed
if ! command -v rclone -V &> /dev/null
then
    # install rclone
    sudo apt install rclone -y
    echo "rclone is now installed"
else
    echo "rclone is installed already"
fi

# if nothing is configured in rclone yet, run configuration
if ! command -v rclone listremotes &> /dev/null
then
    # configure rclone
    rclone config
else
    echo "not initiating any further rclone configuration because remote already exists"
    rclone listremotes
fi

# prompt for rclone mounting
### MAKE THIS LOOP SO YOU CAN ADD AS MANY REMOTES AND MOUNTS AS WANTED
echo "Do you want to mount an rclone remote? y or n"

read answer

while [ "$answer" != "y" -a "$answer" != "n" ]
do
    echo "Do you want to mount an rclone remote? y or n"
    read answer
done

if [ "$answer" == "y" ]
then
    echo "Your rclone remotes are:"
    rclone listremotes
    echo ""
    echo "Would you like to see the contents of a remote? y or n"
    read see_contents


    echo "Enter the name of the remote you want to mount"
    read remote_name
    echo "Enter the path of the remote folder you want to mount. Leave blank to mount root."
    read remote_folder_name
    echo "Enter the path of the local folder you want to mount to - can use ~ for HOME folder"
    read local_folder_name

    # mount cloud storage with rclone
    #rclone mount OneDrive:Personal ~/Personal --daemon && rclone mount OneDrive:Business ~/Business --daemon
    rclone mount "$remote_name":"$remote_folder_name" "$local_folder_name" --daemon
else
    echo "If you decide to mount a folder later, run \'rclone mount --help\' for instructions."
fi

# mount cloud storage with rclone
#rclone mount OneDrive:Personal ~/Personal --daemon && rclone mount OneDrive:Business ~/Business --daemon

# add script to mount cloud storage on startup

# install python 3

# install gnome tweaks

# install vs code

# install git

# other programs

echo "You may also want to install: Lutris"
echo "If you are installing Lutris, and want to use Xbox One S controller, make sure to edit
    /etc/default/grub and add the kernel flag 'bluetooth.disable_ertm=1' to the GRUB_CMDLINE_LINUX line.
    Then run 'sudo grub-mkconfig -o /boot/grub/grub.cfg' and reboot."

# reboot system
