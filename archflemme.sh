mkfs.ext4 /dev/sda1
pacman -Syy
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector -c "FR" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
mount /dev/sda1 /mnt
pacstrap /mnt base linux linux-firmware vim nano
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
pacman -Sy grub sudo cni-plugins dhcpcd qemu-guest-agent openssh
systemctl enable --now sshd
systemctl enable --now dhcpcd
echo HOSTNAME > /etc/hostname
cat <<EOF | sudo tee /etc/hosts  
127.0.0.1	localhost
::1		localhost
127.0.1.1	HOSTNAME
EOF
passwd
