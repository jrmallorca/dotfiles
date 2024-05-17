#!/bin/bash

# This script is designed to be run as a systemd service.
# $HOME and $USER_HOME must be set in the systemd service file.

export KOPIA_PASSWORD="$(bws secret get 2dd616e2-2878-433b-add6-b17300d1e42c | jq -r '.value')"
export BACKBLAZE_B2_KEY="$(bws secret get 9c37d298-3bac-4e06-9887-b17300d2ca6b | jq -r '.value')"

kopia repository connect b2 --bucket=jon-kopia-repository --key-id=0036e07bcb356420000000002 --key=$BACKBLAZE_B2_KEY
kopia snapshot create $USER_HOME
kopia maintenance run --full
kopia repository disconnect
