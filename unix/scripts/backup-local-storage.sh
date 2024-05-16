#!/bin/bash

# This script is designed to sync with the local backup to external storage
#
# This script is designed to be run as a systemd service.
# $HOME and $MOUNTED_DRIVE must be set in the systemd service file.

# Get the password to the repository through BitWarden Secrets Manager
export KOPIA_PASSWORD="$(bws secret get 9d477dbe-c343-43d4-a9d2-b17201547ad3 | jq '.value')"

kopia repository connect filesystem --path $HOME/kopia-backup/
kopia repository sync-to filesystem --path /mnt/pioneer-ssd --must-exist --update --delete
kopia maintenance run --full
kopia repository disconnect
