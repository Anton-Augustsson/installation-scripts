echo ' 
arch linux desktop installation script 
'

USER=anton
HOSTNAME=arch-thinkpad
DOTFILES=https://github.com/Anton-Augustsson/dotfiles.git

# Pre installtion
pacman -Syu --noconfirm
#pacman -S --noconfirm python-mako usbmuxd

# Desktop environment
pacman -S --noconfirm dialog wpa_supplicant xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils w3m scrot sxhkd brightnessctl stow
systemctl enable lightdm

## terminal
pacman -S --noconfirm rxvt-unicode powerline ranger zathura zathura-pdf-mupdf zathura-djvu

## Applications
pacman -S --noconfirm firefox nautilus arduino kicad openscad dia cura deluge  # unexpected error? somthing with python, urxvt fails.

## yay 
cd /home/$USER/Programs
git clone https://aur.archlinux.org/yay.git
chmod 777 yay
cd yay
sudo -u $USER makepkg -si  

### yay applicatinos  fails then crashes i3
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
cd /home/$USER
git clone $DOTFILES
cd dotfiles
#rm /home/$sudo -u $USER/.bashrc
#rm  /home/$USER/.bashrc
rm  /home/$USER/.zshrc
sudo -u $USER stow urxvt emacs zsh ranger zathura 

## Programing 
pacman -S ispell texlive-most
echo "export EDITOR=/usr/bin/emacs" >> ~/.zshrc

## desktop language
sudo -u $USER localectl set-keymap se
sudo -u $USER localectl set-x11-keymap se  #no command found deed after desktop evirometn

## errors
#git,wget
#python-mako
#usbmuxd
#pkdbuild
#sudo yay not found need user
#unable to open sedplay
# desktop enviroment breakes possibly because of:  i3 polybar sxhkd bash
# sudo -u $USER localectl set-x11-keymap se  #no command found deed after desktop evirometn
