#!/bin/bash  
# Absurd MTRX Server Installer
# update packages
sudo apt-get update && sudo apt-get upgrade

# prerequisites
sudo apt-get install -y less libpcre3 git

# clone htan to /usr/lib/htan
sudo git clone https://github.com/adminstock/htan.git /usr/lib/htan

# create symbolic links to htan
[[ -f /sbin/htan ]] || sudo ln -s /usr/lib/htan/run /sbin/htan
[[ -f /usr/sbin/htan ]] || sudo ln -s /usr/lib/htan/run /usr/sbin/htan

# set permissions
sudo chmod u=rwx /usr/lib/htan/run

# run
sudo htan
cd /usr/lib/htan/
sudo git fetch origin && \
sudo git reset --hard origin/master && \
chmod u=rwx /usr/lib/htan/run
apt install wget
wget https://raw.githubusercontent.com/ephidrineon/matrix-synapse-easy-install/main/matrix-synapse-easy-install.sh && chmod +x ./matrix-synapse-easy-install.sh && sudo ./matrix-synapse-easy-install.sh
echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list
wget https://prosody.im/files/prosody-debian-packages.key -O- | sudo apt-key add -
curl https://download.jitsi.org/jitsi-key.gpg.key | sudo sh -c 'gpg --dearmor > /usr/share/keyrings/jitsi-keyring.gpg'
echo 'deb [signed-by=/usr/share/keyrings/jitsi-keyring.gpg] https://download.jitsi.org stable/' | sudo tee /etc/apt/sources.list.d/jitsi-stable.list > /dev/null

# update all package sources
sudo apt update
apt install ufw
systemctl start ufw
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 10000/udp
sudo ufw allow 22/tcp
sudo ufw allow 3478/udp
sudo ufw allow 5349/tcp
sudo ufw enable
sudo /usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh
sudo apt install jitsi-meet
