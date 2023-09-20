#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
rpm -ivh https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
rpm -ivh https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
rpm -ivh /tmp/ublue-os-udev-rules.noarch.rpm

wget https://raw.githubusercontent.com/ublue-os/main/main/main-post-install.sh -P /tmp/config/scripts
chmod +x /tmp/config/scripts/main-post-install.sh