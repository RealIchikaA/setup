#!/bin/bash
sudo apt purge snapd
rm -rf ~/snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
sudo apt update -y && sudo apt install openssh-server -y
sudo bash -c 'cat > /etc/wsl.conf << EOL
[network]
generateResolvConf = false

[boot]
systemd=true
EOL'
sudo mv /etc/ssh/ssh_config /etc/ssh/ssh_config.old
sudo bash -c 'cat > /etc/ssh/ssh_config << EOL
Include /etc/ssh/ssh_config.d/*.conf
Host *
    PasswordAuthentication yes
    Port 22
    SendEnv LANG LC_*
    PermitRootLogin yes
EOL'
sudo bash -c 'cat > /etc/resolv.conf << EOL
[network]
nameserver 1.1.1.1
nameserver 1.0.0.1
EOL'
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 
sudo dpkg -i cloudflared.deb && 
sudo cloudflared service install <key>

echo "Configuration updated. Please restart WSL by running 'wsl --shutdown' from a PowerShell or Command Prompt, and then restart your WSL instance."
hostname -I
