sudo apt update
reboot
sudo apt upgrade
sudo vi installation.sh
sudo chmod +x installation.sh && sudo bash installation.sh




##############################################################################
echo "Main Ubuntu 18.04 LTS Desktop Installation script Rev1.1"
echo "




Installing general


"


sudo apt-get update
sudo apt-get install ranger caca-utils highlight atool w3m poppler-utils mediainfo


sudo apt install net-tools
# general 
sudo apt install gcc
sudo apt install net-tools
echo "Installing curl"
sudo apt install curl -y
echo " Installing terminator*"
sudo apt install terminator -y
echo " installing git"
sudo apt install git  -y
sudo snap install git-repo
sudo apt  install repo
echo " Installing spotify"
sudo snap install spotify
echo " Installing openssh-server"
sudo apt install -y openssh-server
echo " rager"
sudo apt install ranger
echo " feh"
sudo apt install feh﻿
echo "




Installing i3 window manager


"
sudo apt-get install i3
#git pull config file
echo "




Installing emacs


"
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26 -y
# git pull emacs init file
echo "




Installing docker


"
#docker (verified)
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce  -y
echo "




Installing nvidia drives


"
# nvidia drives
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt install nvidia-driver-396
echo "




Installing azuredatastudio


"
# azuredatastudio (verified)
sudo apt-get install libxss1  -y
sudo apt-get install libgconf-2-4  -y
sudo apt-get install libunwind8  -y
wget -O azuredatastudio-linux-1.5.2.deb https://go.microsoft.com/fwlink/?linkid=2083327
dpkg -i ./azuredatastudio-linux-1.5.2.deb
echo "




Installing obs


"
# obs (verified)
sudo apt-get update
sudo apt-get install ffmpeg  -y
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt-get update
sudo apt-get install obs-studio  -y
echo "




Installing openshot


"
# openshot (verified)
sudo add-apt-repository ppa:openshot.developers/ppa
sudo apt-get update
sudo apt-get install openshot-qt  -y
echo "




All done.


"
read -p "press any key to reboot"
reboot
##############################################################################




# test installation script
Ctrl Alt T > open terminator
emacs > opens emacs
spotify > opens spotify
conda list > no error
python -V > anaconda
pip -V >anaconda
sudo systemctl status docker
azuredatastudio
obs-studio
openshot














# pyodbc (verified)
sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install msodbcsql17
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
pip install pyodbc




# optional: for unixODBC development headers
sudo apt-get install unixodbc-dev

# that whats cased all the problems  DONT DELETE ME!!!!!!!!!!
#sudo find /home/anton/anaconda3 -type d -exec chmod a+rwx {} \;
#if that dosent work try
#sudo find /home/anton/anaconda3 -type f -exec chmod a+rwx {} \;


sudo apt install build-essential
sudo apt install g++
