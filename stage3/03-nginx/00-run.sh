#!/bin/bash -e

## Nginx reverse proxy
######################

on_chroot << EOF
unlink '/etc/nginx/sites-enabled/default'
ln -s '/etc/nginx/sites-available/delta5' '/etc/nginx/sites-enabled/delta5'
EOF
