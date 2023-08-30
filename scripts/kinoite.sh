#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
rpm-ostree install --assumeyes --apply-live --force-replacefiles /tmp/ublue-os-update-services.noarch.rpm /tmp/ublue-os-udev-rules.noarch.rpm

wget https://raw.githubusercontent.com/ublue-os/main/main/main-post-install.sh -P /tmp/scripts/post
chmod +x /tmp/scripts/post/main-post-install.sh