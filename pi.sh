sudo parted -s /dev/sda mklabel gpt unit TB mkpart primary 0TB 3.7TB
sudo mkfs.ext4 /dev/sda1
sudo mount /dev/sda1 /longterm-backup


sudo apt update
sudo apt install samba -y
sudo systemctl status nmbd
sudo ufw allow 'Samba'
sudo smbpasswd -a root
sudo smbpasswd -e root
sudo mkdir /longterm-backup
sudo chmod 777 /longterm-backup
sudo echo '[longterm-backup]
        path = /longterm-backup
        browseable = yes
        read only = no
        force create mode = 0660
        force directory mode = 2770
        valid users = root' >> /etc/samba/smb.conf
sudo systemctl restart nmbd
