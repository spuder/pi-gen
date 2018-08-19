#!/bin/bash -e


## Install delta 5
##################

install -v -m 644 files/livetime.service ${ROOTFS_DIR}/lib/systemd/system/livetime.service

# The livetime service is not enabled on boot because it would conflict with the delta5 service
# You must stop delta5 and start livetime manually
on_chroot << EOF
systemctl daemon-reload
EOF
