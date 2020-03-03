echo ' 
arch-linux-installation script 
'
# Base install
EDITOR=emacs visudo 
DRIVE=/dev/xvda
USER=anton
HOSTNAME=arch-thinkpad

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
cd /home/anton
sudo -u anton mkdir Downloads Documents Pictures Pictures/wallpaper Pictures/Screenshots Programs School Dev Woodworking Electronics Openscad KiCad

## zsh
#pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting
#chsh -s /bin/zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# Desktop environment
#pacman -S --noconfirm dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils powerline w3m scrot sxhkd brightnessctl net-tools stow
#systemctl enable lightdm


## Applications
#pacman -S --noconfirm rxvt-unicode firefox ranger nautilus arduino kicad openscad zathura zathura-pdf-mupdf zathura-djvu dia cura deluge 

## yay
#pacman -S --noconfirm --needed base-devel git
#cd /home/anton/Programs
#sudo -u anton git clone https://aur.archlinux.org/yay.git
#chmod 777 yay
#cd yay
#sudo -u anton makepkg -si

#sudo -u anton yay -S siji termsyn-font polybar betterlockscreen

## printer
#pacman -S --noconfirm cups cups-pdf gtk3-print-backends system-config-printer
#systemctl enable org.cups.cupsd.service
#systemctl start org.cups.cupsd.service
#sudo -u anton yay -S brother-mfc-l2700dw

## configuration files
#wget -q https://github.com/Anton-Augustsson/installation-scripts/raw/master/united/wallpaper.jpg -O /home/anton/Pictures/wallpaper/wallpaper.jpg
#betterlockscreen -u /home/anton/Pictures/wallpaper/wallpaper.jpg

### Stow
#cd /home/anton
#git clone https://github.com/anton-1999/dotfiles.git
#cd dotfiles
#rm /home/anton/.bashrc
#sudo -u anton stow urxvt emacs zsh ranger zathura 
# desktop enviroment breakes possibly because of:  i3 polybar sxhkd bash

## Programing languge
#pacman -S ispell texlive-most
#echo "export EDITOR=/usr/bin/emacs" >> ~/.zshrc

## desktop language
#localectl set-keymap se
#localectl set-x11-keymap se  #no command found 

# End
echo '
# Finnish
exit
umount -R /mnt
reboot
'
