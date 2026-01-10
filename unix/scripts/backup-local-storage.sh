#!/bin/bash

# This script is designed to sync with the local backup to external storage.
# Must be run with sudo

if mountpoint /mnt/backup/; then
    # Get the BWS access token from root and the Kopia repository password
    set -a
    . ~/bws-access-token-env
    set +a
    export KOPIA_PASSWORD="$(bws secret get 9d477dbe-c343-43d4-a9d2-b17201547ad3 | jq -r '.value')"

    kopia repository connect filesystem --path $HOME/kopia-backup/ &&
        kopia repository sync-to filesystem --path /mnt/backup --must-exist --update --delete &&
        kopia maintenance run --full
    kopia repository disconnect
else
    echo "Not mounted onto /mnt/backup/. Please check that your USB or drive is mounted in /mnt/backup/"
fi
