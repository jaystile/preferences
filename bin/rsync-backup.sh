#!/bin/bash
# Backs up to the synology mounts.
# Remember this usually is run as root, the prompt for password is for the 'su'
#su "${USER}" --command "rsync -av -e ssh /home/${USER} ${USER}@192.168.1.2:/volume1/homes/"
time su "${USER}" --command "rsync -avP --delete-delay --exclude-from "/home/${USER}/bin/rsync-exclude-list.txt" /home/${USER}/ /mnt/home/${USER}"
