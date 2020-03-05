echo ' 
arch-linux-installation script 
'
# Base install
EDITOR=emacs visudo 
DRIVE=/dev/xvda
USER=anton
HOSTNAME=arch-thinkpad
DOTFILES=https://github.com/Anton-Augustsson/dotfiles.git

## Host configuration
echo $HOSTNAME >> /etc/hostname
echo "
127.0.0.1    localhost
::1          localhost
127.0.1.1    $HOSTNAME.localdomain    $HOSTNAME
"  >> /etc/hosts

echo '
write your password root
'
passwd

useradd -m -G wheel -s /bin/bash $USER
echo '
write your password user
'
passwd $USER


## Region specific configuration
echo '
en_GB.UTF-8 UTF-8
en_GB ISO-8859-1
sv_SE.UTF-8 UTF-8
sv_SE ISO-8859-1
' >> /etc/locale.gen
locale-gen

echo '
LANG=en_GB.UTF-8
' >> /etc/locale.conf
source /etc/locale.conf

echo '
KEYMAP=sv-latin1
' >>/etc/vconsole.conf
source /etc/vconsole.conf

#LANGUAGE=en_GB:en #untested
#export LC_ALL="en_GB.UTF-8"
#export LC_MESSAGES="en_GB.UTF-8"
#export LC_COLLATE="en_GB.UTF-8"

ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc

pacman -Syu

## Mirroring list
pacman -S --noconfirm pacman-contrib
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist


## Network
pacman -S --noconfirm jre-openjdk networkmanager
systemctl enable NetworkManager

### ssh
pacman -S --noconfirm openssh
systemctl enable sshd
systemctl start sshd


## Boot loader
pacman -S --noconfirm grub
grub-install $DRIVE
grub-mkconfig -o /boot/grub/grub.cfg


## Directory anton home
cd /home/$USER
sudo -u $USER mkdir Downloads Documents Pictures Pictures/wallpaper Pictures/Screenshots Programs School Dev Woodworking Electronics Openscad KiCad

## Baic tool installation
pacman -S net-tools git

## zsh
pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting
sudo -u $USER chsh -s /bin/zsh
sudo -u $USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# End
echo '
# Finnish
exit
umount -R /mnt
reboot
'
