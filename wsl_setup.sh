#!/bin/bash
sudo apt purge snapd
rm -rf ~/snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
sudo apt update -y
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt update -y && sudo apt install openssh-server docker.io docker-compose tailscale -y
sudo mv /etc/ssh/ssh_config /etc/ssh/ssh_config.old
sudo bash -c 'cat > /etc/ssh/ssh_config << EOL
Include /etc/ssh/ssh_config.d/*.conf
Host *
    PasswordAuthentication yes
    Port 22
    PermitRootLogin yes
EOL'
sudo usermod -aG docker $USER
echo "Configuration updated. Please restart WSL by running 'wsl --shutdown' from a PowerShell or Command Prompt, and then restart your WSL instance."
hostname -I
sudo tailscale up

