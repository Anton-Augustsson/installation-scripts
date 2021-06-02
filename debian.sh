#!/usr/bin/env bash
set -euo pipefail

# Gloabal variables
EDITOR=emacs
BROWSER=chromium

DOTFILES=https://github.com/Anton-Augustsson/dotfiles.git
USER=$(who | awk 'NR==2 {print $1}')

# write a message as a argument
prompt() {
    while true
    do
        read -r -p "$1 [Y/n] " input

        case $input in
            [yY][eE][sS]|[yY])
                $2
                break
                ;;
            [nN][oO]|[nN])
                $3
                break
                    ;;
            *)
            echo "Invalid input..."
            ;;
        esac
    done
}

welcome() {
    echo '
    debian-installation script
    '
    prompt "Do you wish to preside with the installation as $USER?" $(echo "prosiding") $(exit 0)
}

dependencies() {
    apt install curl git wget net-tools sudo $EDITOR
}

# mirror_list

# sudo usermod -a -G sudo $USER


#
gitConf() {
    read -r -p "Git email: " gitEmail
    read -r -p "Git name: " gitName

    prompt "Confinnue with $gitEmail and $gitNme" $(echo "confinuing") $(exit 0)

    sudo -u $USER git config --global user.email $gitEmail
    sudo -u $USER git config --global user.name $gitName
}

application() {
    apt install --yes $BROWSER ranger w3m vlc nautilus arduino kicad openscad zathura scrot gimp gdb
}

directory() {
    cd /home/$USER
    sudo -u $USER mkdir Programs Downloads Pictures Pictures/wallpaper Pictures/Screenshots
    sudo -u $USER mkdir Documents School
    sudo -u $USER mkdir Development Development/electronics Development/programing Development/woodworking
}

zsh() {
    apt-get install zsh zsh-syntax-highlighting git powerline
    sudo -u $USER chsh -s /bin/zsh
    cd /home/$USER
    sudo -u $USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" #moves inside zshell need to exit to continu
    sudo -u $USER git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:=/home/$USER/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

dwm() {
    sudo apt-get install dwm suckless-tools stterm dmenu xorg sxhkd
    echo dwm > .xsession
    sudo -u $USER git clone https://github.com/Anton-Augustsson/dwm_bar.git /home/$USER/.config/dwm_bar
    sudo -u $USER chmod +x /home/$USER/.config/dwm_bar/dwm_bar.sh
}

stow() {
    apt install --yes stow
    cd /home/$USER
    sudo -u $USER git clone $DOTFILES
    cd dotfiles
    rm /home/$USER/.zshrc
    mv /home/$USER/.oh-my-zsh /home/$USER/.config/oh-my-zsh
    sudo -u $USER stow sxhkd emacs zsh ranger zathura wallpaper
}


end() {
    echo '
    # Finnish
    exit
    umount -R /mnt
    reboot
    '
}

# Installation function
install() {
    welcome
    dependencies
    gitConf
    application
    directory
    zsh
    dwm
    stow
    end
}


# Acctual install
install
