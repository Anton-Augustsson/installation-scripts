
#sudo parted -s /dev/sdb mklabel gpt unit TB mkpart primary 0TB 3.7TB
#sudo parted -s /dev/sdc mklabel gpt unit TB mkpart primary 0TB 3.7TB
#mkfs.ext4 /dev/sdb1
#mkfs.ext4 /dev/sdc1
#sudo echo '/dev/sdb1           /plex  ext4        defaults            0           0' >> /etc/fstab
#sudo echo '/dev/sdc1           /usldb  ext4        defaults            0           0' >> /etc/fstab

sudo vi installation.sh
sudo chmod +x installation.sh
bash installation.sh


##############################################################################
echo "backup-server Ubuntu 18.04 LTS server Installation script Rev1.0"
echo "




Installing general 


"
sudo apt install net-tools -y
# general (verified)
sudo apt install gcc -y
echo "Installing curl"
sudo apt install curl -y
echo " Installing emacs26.2"
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26 -y
scp anton@192.168.1.111:/home/anton/.emacs /home/anton/.emacs
echo " Installing openssh-server"
sudo apt install -y openssh-server
echo "




Installing samba


"
sudo apt update
sudo apt install samba -y
sudo systemctl status nmbd -y
sudo ufw allow 'Samba'
sudo smbpasswd -a root
sudo smbpasswd -e root
sudo mkdir /backup
sudo chmod 777 /backup
sudo echo '[backup]
        path = /backup
        browseable = yes
        read only = no
        force create mode = 0660
        force directory mode = 2770
        valid users = root' >> /etc/samba/smb.conf
sudo systemctl restart nmbd
echo "




File system


"


sudo parted -s /dev/sdb mklabel gpt unit TB mkpart primary 0TB 3.7TB
mkfs.ext4 /dev/sdb1
sudo echo '/dev/sdb1           /backup  ext4        defaults            0           0' >> /etc/fstab
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
sudo chmod a+rwx /home/anton/anaconda3
echo "




All done.


"
read -p "press any key to reboot"
sudo reboot
##############################################################################
