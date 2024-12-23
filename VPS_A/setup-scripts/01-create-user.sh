#!/bin/bash

set -e

USERNAME=ferenc

echo -n "Password for new user $USERNAME: "
stty_orig=`stty -g`
stty -echo
read PASSWORD
stty $stty_orig

echo -e "$PASSWORD\n$PASSWORD\n\n\n\n\ny\n" | adduser "$USERNAME"
usermod -aG sudo "$USERNAME"

set -exv

cat <<EOF | sudo tee /home/$USERNAME/setup-ssh.sh 
#!/bin/sh
mkdir -p ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIK/EIkXDpYIAJtJHdDG/0B7ttEzNNCfr0KxiYnGWnuB ed25519-key-20221228" >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 400 ~/.ssh/authorized_keys
EOF
chmod 755 /home/$USERNAME/setup-ssh.sh

sudo -u "$USERNAME" /home/$USERNAME/setup-ssh.sh
rm -f /home/$USERNAME/setup-ssh.sh

chmod 660 /etc/sudoers
echo "$USERNAME ALL = NOPASSWD : ALL" >> /etc/sudoers
chmod 440 /etc/sudoers

apt-get update
apt-get install -y git

