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
    Pop!_OS installation script

    RUN AS User
    This script dose not install Pop!_OS itself but configuere and installes application.
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
    sudo apt install --yes aptitude 
}


vscode() {
    sudo aptitude install --yes code openscad texlive-latex-extra

    # VS_Code extensions 
    code --install-extension Antyos.openscad
    code --install-extension ritwickdey.LiveServer
    code --install-extension Gimly81.matlab
    code --install-extension vscodevim.vim
    code --install-extension ArtisanByteCrafter.poptheme
    code --install-extension James-Yu.latex-workshop
    code --install-extension znck.grammarly
    code --install-extension aaron-bond.better-comments
}


# Installation function
install() {
    welcome
    gitConf
    dependencies
    application
    directory
    zsh
    dwm
    stow
    end
}


# Acctual install
install