#!/bin/bash
sudo apt purge snapd
rm -rf ~/snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt update -y && sudo apt install openssh-server docker.io docker-compose tailscale -y
sudo usermod -aG docker $USER
hostname -I
echo "Restart WSL by running 'wsl --shutdown' from a PowerShell or cmd NOW."
history -c
sudo tailscale up --ssh

