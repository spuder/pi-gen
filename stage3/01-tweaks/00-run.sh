#!/bin/bash -e


on_chroot << EOF
groupadd -f -r -g 1001 delta5
useradd -u 1001 -g 1001 -rm delta5
EOF

## Install i2c kernel modules
## http://bit.ly/1igFto4
#############################

on_chroot << EOF
echo 'i2c-bcm2708' >> /etc/modules
echo 'i2c-dev' >> /etc/modules
EOF

# https://stackoverflow.com/a/28515418/1626687
on_chroot << EOF
echo "dtparam=i2c1=on" >> /boot/config.txt
echo "dtparam=i2c_arm=on" >> /boot/config.txt
EOF

## Install delta 5
##################

# Make /opt/delta5 dir and chown to user delta5(1001)
install -v -o 1001 -g 1001 -d ${ROOTFS_DIR}/opt/delta5

on_chroot << EOF
cd /opt/delta5
git clone https://github.com/scottgchin/delta5_race_timer /opt/delta5
chown -R delta5:pi /opt/delta5
cd /opt/delta5/src/delta5server
yes | pip install -r requirements.txt
EOF

install -v -m 644 files/delta5.service ${ROOTFS_DIR}/lib/systemd/system/delta5.service

on_chroot << EOF
systemctl daemon-reload
systemctl enable delta5.service
EOF

on_chroot << \EOF
for GRP in dialout gpio spi i2c video; do
        adduser delta5 $GRP
done
for GRP in delta5; do
  adduser pi $GRP
done
EOF

## Nginx reverse proxy
######################

install -v -m 644 files/nginx ${ROOTFS_DIR}/etc/nginx/sites-available/delta5

on_chroot << EOF
unlink '/etc/nginx/sites-enabled/default'
ln -s '/etc/nginx/sites-available/delta5' '/etc/nginx/sites-enabled/delta5'
EOF
