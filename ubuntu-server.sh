sudo vi installation.sh
sudo chmod +x installation.sh
bash installation.sh


echo "Ubuntu 18.04 LTS server Installation script Rev1.0"
echo "




Installing samba


"
sudo apt update
sudo apt install samba -y
sudo systemctl status nmbd
sudo ufw allow 'Samba'
sudo smbpasswd -a root
sudo smbpasswd -e root
sudo mkdir /plex
sudo chmod 777 /plex
sudo echo '[plex]
        path = /plex
        browseable = yes
        read only = no
        force create mode = 0660
        force directory mode = 2770
        valid users = root' >> /etc/samba/smb.conf
sudo systemctl restart nmbd
echo "






Installing mssql tools


"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
sudo apt-get update
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
sudo apt-get update
sudo apt-get install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup
echo "




Installing mssql tools


"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update
sudo apt-get install mssql-tools unixodbc-dev -y
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
sqlcmd -S localhost -U SA -P 'Anaug-1999AA'
echo "




installing plex


"
sudo apt-get update
wget https://downloads.plex.tv/plex-media-server-new/1.15.2.793-782228f99/debian/plexmediaserver_1.15.2.793-782228f99_amd64.deb
sudo dpkg -i plexmediaserver_1.15.2.793-782228f99_amd64.deb
echo "all done"
sudo reboot














sudo parted -s /dev/sdb mklabel gpt unit TB mkpart primary 0TB 3.7TB
sudo parted -s /dev/sdc mklabel gpt unit TB mkpart primary 0TB 3.7TB
mkfs.ext4 /dev/sdb1
mkfs.ext4 /dev/sdc1
sudo echo '/dev/sdb1           /plex  ext4        defaults            0           0' >> /etc/fstab
sudo echo '/dev/sdc1           /usldb  ext4        defaults            0           0' >> /etc/fstab


R10
sudo echo '/dev/sdb1           /backup  ext4        defaults            0           0' >> /etc/fstab






#static ip
sudo vi /etc/netplan/50-cloud-init.yaml
#edit conf file
network:
    ethernets:
        enp0s3:
            addresses: [192.168.1.210/24]
            gateway4: 192.168.1.1
            nameservers:
              addresses: [8.8.8.8,8.8.4.4]
            dhcp4: no
    version: 2
#:wq

4000225165312
4294967294
7812939776

https://www.cyberciti.biz/tips/fdisk-unable-to-create-partition-greater-2tb.html
https://linuxconfig.org/how-to-manage-partitions-with-gnu-parted-on-linux no lyck
https://medium.com/@sh.tsang/partitioning-formatting-and-mounting-a-hard-drive-in-linux-ubuntu-18-04-324b7634d1e0
sudo parted -s /dev/sdb mklabel gpt unit TB mkpart primary 0TB 3.7TB
sudo mount /dev/sdc /mnt/sdc
mkfs.ext4 /dev/sdc1
sudo mount /dev/sdc1 /usldb
vi /etc/fstab



sudo passwd root
nano /etc/ssh/sshd_config
sudo echo /etc/ssh/sshd_config ‘PermitRootLogin yes’


#installation samba
sudo apt update
sudo apt install samba
sudo systemctl status nmbd
sudo ufw allow 'Samba'
#user set user 
sudo useradd root
sudo smbpasswd -a root
sudo smbpasswd -e root
# dir setup
sudo mkdir /movies
sudo chmod 777 /movies
sudo mkdir /series
sudo chmod 777 /series
#configuration
sudo vi /etc/samba/smb.conf
#edit in configuration file
[movies]
    path = /movies
    browseable = yes
    read only = no
    force create mode = 0660
    force directory mode = 2770
    valid users = root

[series]
    path = /series
    browseable = yes
    read only = no
    force create mode = 0660
    force directory mode = 2770
    valid users = root
#:wq
#restart samba
sudo systemctl restart nmbd

#Mount harddrives https://www.binarytides.com/ubuntu-automatically-mount-partition-startup/
sudo vi /etc/fstab

 
#Installing sql https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-2017 
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
sudo apt-get update
sudo apt-get install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup
#3
#yes
#
# optional systemctl restart mssql-server.service
systemctl status mssql-server

#command line tools
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update
sudo apt-get install mssql-tools unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
sqlcmd -S localhost -U SA -P 'Anaug-1999AA'
CREATE DATABASE plex
GO
QUIT


#installing plex
sudo apt-get update
wget https://downloads.plex.tv/plex-media-server-new/1.15.2.793-782228f99/debian/plexmediaserver_1.15.2.793-782228f99_amd64.deb
sudo dpkg -i plexmediaserver_1.15.2.793-782228f99_amd64.deb
systemctl status plexmediaserver



    #reboot
sudo reboot


#testing
http://192.168.1.210:32400/web/index.html
Azure studio
