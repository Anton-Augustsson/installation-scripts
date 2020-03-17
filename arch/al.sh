# Gloabal variables
DRIVE=/dev/xvda

welcome()
{
    echo ' 
    arch-linux-installation script 
    '
}

user()
{
    #echo 'foobar ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
    EDITOR=emacs visudo

    useradd -m -G wheel -s /bin/bash anton
    echo '
    write your password user
    '
    passwd anton
}

host_conf()
{
    echo 'arch-thinkpad' >> /etc/hostname
    echo '
    127.0.0.1    localhost
    ::1          localhost
    127.0.1.1    al-thinkpad.localdomain    al-thinkpad
    '  >> /etc/hosts
}

password()
{
    echo '
    write your password root
    '
    passwd

}

swe_conf()
{
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
    
    localectl set-keymap se
    localectl set-x11-keymap se

}

mirror_list()
{
    pacman -S --noconfirm pacman-contrib
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
}

network()
{
    pacman -S --noconfirm jre-openjdk networkmanager
    systemctl enable NetworkManager
}

ssh()
{
    pacman -S --noconfirm openssh
    systemctl enable sshd
    systemctl start sshd
}

grub()
{
    pacman -S --noconfirm grub
    grub-install $DRIVE 
    grub-mkconfig -o /boot/grub/grub.cfg
}

directory()
{
    cd /home/anton
    sudo -u anton mkdir Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
    chmod 777 Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
}

zsh()
{
    pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting
    chsh -s /bin/zsh
}

i3()
{
    pacman -S --noconfirm dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils
    systemctl enable lightdm
}

application()
{
    pacman -S --noconfirm rxvt-unicode firefox ranger nautilus arduino kicad openscad
}

yay()
{
    pacman -S --noconfirm --needed base-devel git
    cd /home/anton/Programs
    sudo -u anton git clone https://aur.archlinux.org/yay.git
    chmod 777 yay
    cd yay
    sudo -u anton makepkg -si
}

aur_application()
{
    sudo -u anton yay -S polybar siji termsyn-font
}
