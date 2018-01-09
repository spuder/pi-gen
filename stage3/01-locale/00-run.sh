#!/bin/bash -e

## Set locale to US
LANG=en_US.UTF-8 locale-gen --purge en_US.UTF-8

on_chroot << EOF
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment
EOF
