# Gloabal variables
EDITOR=emacs 
DRIVE=/dev/xvda
USER=anton
HOSTNAME=arch-thinkpad
DOTFILES=https://github.com/Anton-Augustsson/dotfiles.git


welcome() {
    echo ' 
    arch-linux-installation script 
    '
}


host_conf() {
    echo "$HOSTNAME" >> /etc/hostname
    echo "
    127.0.0.1    localhost
    ::1          localhost
    127.0.1.1    $HOSTNAME.localdomain    $HOSTNAME
    "  >> /etc/hosts
}


root_password() {
    echo '
    write your password root
    '
    passwd
}


swe_conf() {
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
}


dependencies() {
    pacman -Syu --noconfirm
    pacman -S --noconfirm --needed base-devel emacs wget net-tools 
}


mirror_list() {
    pacman -S --noconfirm pacman-contrib
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    echo "Creating mirrorlist (This will take a while)"
    rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
}


network() {
    pacman -S --noconfirm jre-openjdk networkmanager
    systemctl enable NetworkManager
}


ssh() {
    pacman -S --noconfirm openssh
    systemctl enable sshd
    systemctl start sshd
}


grub() {
    pacman -S --noconfirm grub
    grub-install $DRIVE 
    grub-mkconfig -o /boot/grub/grub.cfg
}


user() {
    #echo 'foobar ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
    EDITOR=emacs visudo
    useradd -m -G wheel -s /bin/bash $USER
    echo "
    write your password $USER
    "
    passwd $USER
}


directory() {
    cd /home/$USER
    sudo -u $USER mkdir Programs Downloads Pictures Pictures/wallpaper Pictures/Screenshots
    sudo -u $USER mkdir Documents Documents/git-projects School
    sudo -u $USER mkdir Development Development/electronics Development/programing Development/woodworking
}


yay() {
    pacman -S --noconfirm --needed base-devel git
    cd /home/$USER/Programs
    sudo -u $USER git clone https://aur.archlinux.org/yay.git
    chmod 777 yay
    cd yay
    sudo -u $USER makepkg -si 
}


zsh() {
    pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting git
    sudo -u $USER chsh -s /bin/zsh
    cd /home/$USER 
    sudo -u $USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" #moves inside zshell need to exit to continu
    sudo -u $USER git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:=/home/$USER/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    sudo -u $USER git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=/home/$USER/.oh-my-zsh/custom}/plugins/zsh-completions
}


gitConf() {
    pacman -Syu git
    git config --global user.email "anton.augustsson99@gmail.com"
    git config --global user.name "Anton-Augustsson"
}


fonts() {
    pacman -S --noconfirm ttf-font-awesome
    sudo -u $USER yay -S --noconfirm siji nerd-fonts-complete
}


application() {
    pacman -S --noconfirm rxvt-unicode chromium ranger w3m  nautilus arduino kicad openscad zathura zathura-pdf-mupdf zathura-djvu scrot gimp
}


aur_application() {
    sudo -u $USER yay -Syu --noconfirm 
    #sudo -u $USER yay -S --noconfirm 
}


i3() {
    pacman -S --noconfirm dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils
    systemctl enable lightdm
}


dwm() {
    # Core dwm dependencies
    pacman -S --noconfirm xorg xorg-xrandr xorg-xinit xorg-server xorg-xsetroot dmenu alsa-utils
    # Extra dwm dependencies
    pacman -S --noconfirm dialog openssl xwallpaper picom nitrogen sxhkd xlockmore brightnessctl
    
    cd /home/$USER/Programs
    wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz
    tar -xzvf dwm-6.2.tar.gz 
    cd dwm-6.2
    make clean install
}

dwmStatusBar(){
    sudo -u $USER git clone https://github.com/Anton-Augustsson/dwm_bar.git /home/$USER/.config/dwm_bar
    sudo -u $USER chmod +x  /home/$USER/.config/dwm_bar/dwm_bar.sh
}

st() {
    cd /home/$USER/Programs
    git clone https://github.com/LukeSmithxyz/st
    cd st
    make clean install
}


powerline() {
    sudo pacman -S powerline powerline-fonts
}


stow() {
    pacman -S --noconfirm stow
    cd /home/$USER
    sudo -u $USER git clone $DOTFILES
    cd dotfiles
    rm /home/$USER/.zshrc
    mv /home/$USER/.oh-my-zsh /home/$USER/.config/oh-my-zsh
    sudo -u $USER stow sxhkd emacs zsh ranger zathura xorg
}


end() {
    echo '
    # Finnish
    exit
    umount -R /mnt
    reboot
    '
}



# Installation options

installMinimal(){
    host_conf
    root_password
    swe_conf

    dependencies
    mirror_list
    network
    ssh
    grub

    user
    directory
    yay
    zsh
    gitConf
}

installDesktop(){
    fonts
    application
    aur_application
    dwm
    dwmStatusBar
    st
    powerline
    stow
}



# Acctual install

welcome
installMinimal
installDesktop
end
