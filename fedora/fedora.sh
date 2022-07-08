#!/usr/bin/env bash

DOTFILES=https://github.com/Anton-Augustsson/dotfiles.git

# Write a message as a argument
## $1 - The statment or question what should be desplayed before [Y/n] 
## $2 - The function that should be exicuted when pressing [Y]
## $3 - The function that should be exicuted when pressing [n]
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

# Welcome screen
welcome() {
    echo '
    Fedora installation script

    '
    prompt "Do you wish to preside?" $(echo "prosiding") $(exit 0)
}

# Set the git email and user name. Also creates a ssh key and uploweds it to gihub
gitConf() {
    read -r -p "\nGit email: " gitEmail
    read -r -p "Git name: " gitName
    read -r -p "Git access token: " gitToken

    prompt "Confinnue with $gitEmail and $gitNme" $(echo "confinuing") $(exit 0)

    sudo -u $USER git config --global user.email $gitEmail
    sudo -u $USER git config --global user.name $gitName
    
    prompt "Generate ssh-key and upload to github" $(echo "confinuing") $(exit 0)
    ssh-keygen -t ed25519 -C $gitEmail
    key=$(cat ~/.ssh/id_ed25519.pub)
    curl -H "Authorization: token $gitToken" --data '{"title":"test-key","key": "'$key'"}' https://api.github.com/user/keys
}

# These are general dependiecies for many diffrent functions, needs to be run after "welcome()"
dependencies() {
    sudo dnf upgrade
}

# ZSH, vim and ranger
terminalApplication() {
    #sudo aptitude install vim ranger zsh
    # Enable zsh
    #chsh -s $(which zsh)

    # https://linuxhint.com/configure_vim_vimrc/
    # set clipboard=unnamedplus

    # Install Oh my zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Oh-my-ZSH plugin autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    # Oh-my-ZSH plugin syntax highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    # Oh-my-ZSH plugin vi mode
    git clone https://github.com/jeffreytse/zsh-vi-mode.git $ZSH_CUSTOM/plugins/zsh-vi-mode

    # Make sure .zshrc is updated
}

vscode() {
    #sudo aptitude install code openscad texlive-latex-extra

    # VS_Code extensions 
    code --install-extension Antyos.openscad
    code --install-extension ritwickdey.LiveServer
    code --install-extension Gimly81.matlab
    code --install-extension vscodevim.vim
    code --install-extension ArtisanByteCrafter.poptheme
    code --install-extension James-Yu.latex-workshop
    code --install-extension znck.grammarly
    code --install-extension aaron-bond.better-comments

    # https://github.com/VSCodeVim/Vim
    # User/settings
    #"vim.useSystemClipboard": true,
}

zoom() {
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install ./zoom_amd64.deb
}

# Keyboad backlight
backlighting() {
    sudo dnf install brightnessctl
    # make sure script is in place
    # allow user to allow it
    # example key binding /home/anton/Programs/setBacklight.sh
}

rclone() {
    sudo dnf install rclone inotifywait
    
}
# Installation function
install() {
    vscode 
    terminalApplication
}

# Acctual install
install
