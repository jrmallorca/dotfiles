#!/bin/bash

# This script is designed to be run as a systemd service.
# HOME and USER_HOME must be set in the systemd service file.

export KOPIA_PASSWORD="CHANGE_THIS"
kopia repository connect filesystem --path $HOME/kopia-backup/
kopia snapshot create $USER_HOME
kopia maintenance run --full
kopia repository disconnect
