#!/bin/bash

# This script is designed to be run as a systemd service.
# $HOME and $USER_HOME must be set in the systemd service file.

# Get the password to the repository through BitWarden Secrets Manager
export KOPIA_PASSWORD="$(bws secret get 9d477dbe-c343-43d4-a9d2-b17201547ad3 | jq -r '.value')"

kopia repository connect filesystem --path $HOME/kopia-backup/
kopia snapshot create $USER_HOME
kopia maintenance run --full
kopia repository disconnect
