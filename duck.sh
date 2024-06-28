#!/bin/bash
sudo mkdir -p /dns && cd /dns
sudo bash -c 'cat <<EOF > update.sh
#!/bin/bash
echo url="https://www.duckdns.org/update?domains=<domain>&token=mytoken&ip=" | curl -k -o ~/duckdns/duck.log -K -
EOF'
sudo chmod 700 update.sh
(crontab -l ; echo "*/5 * * * * /dns/update.sh >/dev/null 2>&1") | crontab -
