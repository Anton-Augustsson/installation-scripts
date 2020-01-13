#apt update
#reboot
#apt upgrade
#vi installation.sh
#chmod +x installation.sh && bash installation.sh




##############################################################################
echo "Kali linux Installation script Rev1"
echo "




Installing general


"
apt install net-tools
# general 
apt install gcc
apt install net-tools
echo "Installing curl"
apt install curl -y
echo " Installing terminator*"
apt install terminator -y
echo " installing git"
apt install git  -y
snap install git-repo
echo " Installing spotify"
snap install spotify
echo " Installing openssh-server"
apt install -y openssh-server
echo " rager"
apt install ranger
echo " feh"
apt install feh﻿
echo "




Installing i3 window manager


"
apt-get install i3
#git pull config file
echo "




Installing emacs


"
apt install emacs -y
# git pull emacs init file
echo "




Installing Tor


"
adduser anton
wget https://www.torproject.org/dist/torbrowser/8.5.1/tor-browser-linux64-8.5.1_en-US.tar.xz
tar xvzf file.tar.gz -C /home/anton
#cd /home/anton/tor-browser_en-US
#start-tor-browser
#https://hackingpress.com/install-tor-on-kali-linux/
