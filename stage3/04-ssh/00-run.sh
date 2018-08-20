on_chroot << EOF
systemctl enable ssh
touch /boot/ssh
EOF
