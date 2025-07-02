#!/bin/bash

# Argument validation check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <USER_HOME_DIRECTORY>"
    exit 1
fi

kopia repository create filesystem --path $HOME/kopia-backup/
kopia policy set --global --keep-annual 0 --keep-monthly 3 --keep-weekly 4 --keep-daily 7 --keep-hourly 0 --keep-latest 20 --compression=s2-default
kopia repository connect filesystem --path $HOME/kopia-backup/
kopia snapshot create $1
kopia repository disconnect
