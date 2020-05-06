# Gloabal variables
EDITOR=emacs 
DRIVE=/dev/xvda
USER=anton
HOSTNAME=arch-thinkpad
DOTFILES=https://github.com/Anton-Augustsson/dotfiles.git

welcome()
{
    echo ' 
    arch-linux-installation script 
    '
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

root_password()
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
    source /etc/locale.conf

    echo '
    KEYMAP=sv-latin1
    ' >>/etc/vconsole.conf
    source /etc/vconsole.conf

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

directory()
{
    cd /home/anton
    sudo -u anton mkdir Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
    chmod 777 Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
}

zsh()
{
    pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting git
    sudo -u $USER chsh -s /bin/zsh
    sudo -u $USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" #moves inside zshell need to exit to continu
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

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

end()
{
    echo '
    # Finnish
    exit
    umount -R /mnt
    reboot
    '
}


# Acctual install

welcome
host_conf
root_password
swe_conf
mirror_list
ssh
grub
user
directory
zsh
end
