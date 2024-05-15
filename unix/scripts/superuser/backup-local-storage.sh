#!/bin/bash

# This script is designed to sync with the local backup to external storage
#
# This script is designed to be run as a systemd service.
# HOME and $MOUNTED_DRIVE must be set in the systemd service file.

export KOPIA_PASSWORD="CHANGE_THIS"
kopia repository connect filesystem --path /root/kopia-backup/
kopia repository sync-to filesystem --path /mnt/pioneer-ssd --must-exist --update --delete
kopia maintenance run --full
kopia repository disconnect
