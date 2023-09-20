#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
rpm -ivh /tmp/ublue-os-udev-rules.noarch.rpm

wget https://raw.githubusercontent.com/ublue-os/main/main/main-post-install.sh -P /tmp/config/scripts
chmod +x /tmp/config/scripts/main-post-install.sh