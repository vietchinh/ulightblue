#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
rpm-ostree install --assumeyes --apply-live --force-replacefiles /tmp/ublue-os-update-services.noarch.rpm