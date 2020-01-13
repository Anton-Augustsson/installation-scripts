#sudo apt update
#reboot
#sudo apt upgrade
#sudo vi installation.sh
#sudo chmod +x installation.sh && sudo bash installation.sh




##############################################################################
echo "VM Ubuntu 18.04 LTS Desktop Installation script Rev1.0"
echo "




Installing general


"
sudo apt install net-tools
# general (verified)
echo "Installing curl"
sudo apt install curl -y
echo " Installing terminator*"
sudo apt-get install terminator -y
echo " Installing emacs26.2"
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26 -y
echo " Installing spotify"
sudo snap install spotify
echo " Installing openssh-server"
sudo apt install -y openssh-server


echo "




Installing git


"
# git (verified)
sudo apt update
sudo apt install git  -y
echo "




Installing python envirement


"
sudo apt update
wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
sha256sum Anaconda3-2019.03-Linux-x86_64.sh
bash Anaconda3-2019.03-Linux-x86_64.sh
sudo apt update
source ~/.bashrc
echo "




All done, rebooting now 


"
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
