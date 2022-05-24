#!/bin/bash

# disable
systemctl disable fix-mutter-egpu

# clean install
rm -rf /usr/local/fix-mutter-egpu

# start service
systemctl daemon-reload
