#!/bin/bash
# Remember this usually is run as root, the prompt for password is for the 'su'
# su "${USER}" --command "rsync -av -e ssh $USER@192.168.1.2:/volume1/homes/$USER/* /home/$USER/"
# su "${USER}" --command "rsync -avP /mnt/home/$USER/* /home/$USER/"
time su "${USER}" --command "rsync -avP --delete-delay --exclude-from "/home/${USER}/bin/rsync-exclude-list.txt" /mnt/home/${USER}/* /home/${USER}/"
