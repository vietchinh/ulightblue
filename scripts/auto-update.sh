#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
wget https://github.com/ublue-os/main/blob/main/post-install.sh -P /tmp/scripts/post
chmod +x /tmp/scripts/post/post-install.sh