#!/bin/bash

# take backup if exists
cat /usr/lib/udev/rules.d/61-mutter-primary-gpu.rules >61-mutter-primary-gpu.rules.backup

# clean install
rm -rf /usr/local/fix-mutter-egpu

# make folder in /usr/local/
mkdir /usr/local/fix-mutter-egpu

# copy serice into place
cp overwrite-mutter-config /usr/local/fix-mutter-egpu/overwrite-mutter-config

# copy unit file into place
cp fix-mutter-egpu.service /etc/systemd/system/fix-mutter-egpu.service

# start service
systemctl daemon-reload
systemctl start fix-mutter-egpu
systemctl enable fix-mutter-egpu
