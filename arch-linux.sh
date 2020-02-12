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
echo '
KEYMAP=sv-latin1
' >>/etc/vconsole.conf

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
#Openscad (library)
#KiCad (library)
#Arduino (library)


## zsh
pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# Desktop environment
pacman -S --noconfirm dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils powerline w3m scrot sxhkd brightnessctl net-tools stow
# xbindkeys xorg-xbacklight imagemagick feh xorg-xrandr xorg-xdpyinfo w3mimgdisplay imagemagick
systemctl enable lightdm


## Applications
pacman -S --noconfirm rxvt-unicode firefox ranger nautilus arduino kicad openscad zathura zathura-pdf-mupdf zathura-djvu 

## yay
pacman -S --noconfirm --needed base-devel git
cd /home/anton/Programs
sudo -u anton git clone https://aur.archlinux.org/yay.git
chmod 777 yay
cd yay
sudo -u anton makepkg -si

sudo -u anton yay -S siji termsyn-font polybar

## printer
pacman -S --noconfirm cups cups-pdf gtk3-print-backends system-config-printer
systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service
sudo -u anton yay -S brother-mfc-l2700dw

## configuration files
#scp anton@192.168.1.210:/plex/other/mountain1.jpg /home/anton/Pictures/wallpaper/wallpaper.jpg ~
wget -q https://github.com/anton-1999/installation-scripts/raw/master/united/wallpaper.jpg -O ~/Pictures/wallpaper/wallpaper.jpg
betterlockscreen -u /home/anton/Pictures/wallpaper/wallpaper.jpg

#wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.zshrc -O ~/.zshrc
#wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.emacs -O ~/.emacs
#wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.Xdefaults -O ~/.Xdefaults
#wget -q https://github.com/anton-1999/configuration-files/blob/master/config/.config/i3/config -O ~/.config/i3/config
#wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.config/polybar/config -O ~/.config/polybar/config
#wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.config/polybar/launch.sh -O ~/.config/polybar/launch.sh
#wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.config/ranger/rc.conf -O ~/.config/ranger/rc.conf
#wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.config/zathura/zathurarc -O ~/.config/zathura/zathurarc

cd /home/anton
git clone https://github.com/anton-1999/dotfiles.git
cd dotfiles
sudo -u anton stow i3 polybar sxhkd urxvt emacs bash zsh ranger zathura 

## Programing languge
pacman -S ispell ghc ghc-static cabal-install texlive-most
echo "export EDITOR=/usr/bin/emacs" >> ~/.zshrc

### Haskell
#sudo -u anton mkdir haskell
#cd  haskell
#sudo -u anton cabal update
#sudo -u anton cabal user-config update
#sudo -u anton cabal init 
#sudo -u anton cabal configure --disable-library-vanilla --enable-shared --enable-executable-dynamic --ghc-options=-dynamic


## desktop language
sudo -u anton localectl set-keymap se
sudo -u anton localectl set-x11-keymap se

# End
echo '
# Finnish
exit
umount -R /mnt
reboot
'
