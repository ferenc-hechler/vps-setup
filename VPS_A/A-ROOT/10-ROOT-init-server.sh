#!/bin/bash

set -xev

USERNAME=ferenc
useradd -mU -s /bin/bash -G sudo "$USERNAME"

mkdir -p /home/$USERNAME/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIK/EIkXDpYIAJtJHdDG/0B7ttEzNNCfr0KxiYnGWnuB ed25519-key-20221228 ferenc" >> /home/$USERNAME/.ssh/authorized_keys
# echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIK4ByFACB4mmBaFd54tYGOvI3aEyMABHOXe+iVrZB7r eddsa-key-20221124" >> /home/$USERNAME/.ssh/authorized_keys
# add further public SSH keys here

chmod 700 /home/$USERNAME/.ssh
chmod 400 /home/$USERNAME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

chmod 660 /etc/sudoers
echo "$USERNAME ALL = NOPASSWD : ALL" >> /etc/sudoers
chmod 440 /etc/sudoers
