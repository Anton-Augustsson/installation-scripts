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
    echo 'arch-thinkpad' >> /etc/hostname
    echo '
    127.0.0.1    localhost
    ::1          localhost
    127.0.1.1    al-thinkpad.localdomain    al-thinkpad
    '  >> /etc/hosts
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
    pacman -S --noconfirm --needed base-devel git wget net-tools 
}


mirror_list() {
    pacman -S --noconfirm pacman-contrib
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
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
    echo '
    write your password $USER
    '
    passwd $USER
}


directory() {
    cd /home/$USER
    sudo -u $USER mkdir Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
    chmod 777 Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
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
    sudo -u $USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" #moves inside zshell need to exit to continu
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
}


application() {
    pacman -S --noconfirm rxvt-unicode chromium ranger nautilus arduino kicad openscad
}


aur_application() {
    sudo -u $USER yay -S --noconfirm siji termsyn-font
}


i3() {
    pacman -S --noconfirm dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils
    systemctl enable lightdm
}


dwm() {
    pacman -S --noconfirm xorg xorg-xrandr xorg-xinit xorg-server xorg-xsetroot dmenu dialog openssl xwallpaper alsa-utils picom nitrogen
    #sudo -u $USER yay -S libxft-bgra
    cd /home/$USER/Programs
    #git clone https://github.com/LukeSmithxyz/dwm.git
    wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz
    tar -xzvf dwm-6.2.tar.gz 
    cd dwm-6.2
    make clean install
}


st() {
    cd /home/$USER/Programs
    git clone https://github.com/LukeSmithxyz/st
    cd st
    make clean install
}


sxhkd() {
    pacman -S --noconfirm sxhkd
    mkdir /home/$USER/Programs/sxhkd
    cd /home/$USER/Programs/sxhkd
    wget -o https://raw.githubusercontent.com/baskerville/sxhkd/master/contrib/systemd/sxhkd.service /etc/systemd/system/sxhkd.service
    systemctl enable sxhkd
    systemctl start sxhkd
}


stow() {
    cd /home/$USER
    sudo -u $USER git clone $DOTFILES
    cd dotfiles
    rm /home/$USER/.zshrc
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
}

installDesktop(){
    application
    aur_application
    dwm
    st
    sxhkd
    stow
}



# Acctual install

welcome
installMinimal
installDesktop
end
