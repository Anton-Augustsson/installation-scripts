echo ' 
arch-linux-installation script 
'
# Base install
EDITOR=emacs visudo 
DRIVE=/dev/xvda
USER=anton
HOSTNAME=arch-thinkpad
DOTFILES=https://github.com/Anton-Augustsson/dotfiles.git

# Desktop environment
pacman -S --noconfirm dialog wpa_supplicant xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils w3m scrot sxhkd brightnessctl stow
systemctl enable lightdm

## terminal
pacman -S --noconfirm rxvt-unicode powerline ranger zathura zathura-pdf-mupdf zathura-djvu

## Applications
pacman -S --noconfirm firefox nautilus arduino kicad openscad dia cura deluge  # unexpected error? somthing with python, urxvt fails.

## yay
cd /home/$USER/Programs
sudo -u anton git clone https://aur.archlinux.org/yay.git
chmod 777 yay
cd yay
sudo -u $USER makepkg -si
cd

### yay applicatinos
sudo -u $USER yay -S --noconfirm siji termsyn-font polybar betterlockscreen

## printer
pacman -S --noconfirm cups cups-pdf gtk3-print-backends system-config-printer
systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service
sudo -u $USER yay -S --noconfirm brother-mfc-l2700dw

## configuration files
wget -q https://github.com/Anton-Augustsson/installation-scripts/raw/master/united/wallpaper.jpg -O /home/$USER/Pictures/wallpaper/wallpaper.jpg
#betterlockscreen -u /home/anton/Pictures/wallpaper/wallpaper.jpg  # Dosent work it probably desktop enviroment is needed

### Stow
#cd /home/$USER
#git clone $DOTFILES
#cd dotfiles
#rm /home/$sudo -u $USER/.bashrc
#sudo -u $USER stow urxvt emacs zsh ranger zathura 
# desktop enviroment breakes possibly because of:  i3 polybar sxhkd bash

## Programing languge
#pacman -S ispell texlive-most
#echo "export EDITOR=/usr/bin/emacs" >> ~/.zshrc

## desktop language
#sudo -u $USER localectl set-keymap se
#sudo -u $USER localectl set-x11-keymap se  #no command found deed after desktop evirometn

