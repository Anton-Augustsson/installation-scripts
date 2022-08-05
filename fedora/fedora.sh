#! /bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

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

stowConfigure() {
    stow -d $SCRIPT_DIR/dotfiles -t $HOME $1
}

# Welcome screen
welcome() {
    echo '
    Fedora installation script

    '
    #prompt "Do you wish to preside?" $(echo "prosiding") $(exit 0)
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
    sudo dnf install stow
}

# ZSH, vim and ranger
terminalApplication() {
    sudo dnf install zsh vim ranger

    # Enable zsh
    sudo lchsh $USER

    # https://linuxhint.com/configure_vim_vimrc/
    # set clipboard=unnamedplus

    # Install Oh my zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Oh-my-ZSH plugin autosuggestions
    zsh -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
    # Oh-my-ZSH plugin syntax highlighting
    zsh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
    # Oh-my-ZSH plugin vi mode
    zsh -c 'git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode'

    # Make sure .zshrc is updated
    rm $HOME/.zshrc
    stowConfigure zsh
}

emacs() {
    sudo dnf install emacs
    stowConfigure emacs
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
    make -C scripts/setBacklight/
    # make sure script is in place
    # allow user to allow it
    # example key binding /home/anton/Programs/setBacklight.sh
}

rclone() {
    sudo dnf install rclone
    #https://rclone.org/drive/   
    cp scripts/sync_drive.sh ~/Programs/sync_drive.sh
}

rclone() {
    sudo dnf install rclone
    #https://rclone.org/drive/   
    cp scripts/sync_drive.sh ~/Programs/sync_drive.sh
    echo "@reboot ~/Programs/sync_drive.sh" | crontab -
}

flutter() {
    # TODO
    sudo snap install flutter --classic
    sudo snap install android-studio --classic
    #export PATH="$PATH:[PATH_OF_FLUTTER_GIT_DIRECTORY]/bin"
    #source $HOME/.<rc file>
    #https://docs.flutter.dev/get-started/install/linux
    #flutter doctor --android-licenses
    sudo dnf install clang cmake ninja-build pkg-config
}

# Installation function
setupAll() {
    vscode 
    terminalApplication
}

menu() {
    welcome
    while true
    do
	echo "1) Install dependencies"
	echo "2) Setup git"
	echo "3) Setup ZSH"
	echo "4) Setup Emacs"
	echo "5) Setup VSCode"
	echo "6) Setup zoom"
	echo "7) Setup rclone"
	echo "8) Setup keybord backlighting"
	echo "9) Setup Flutter"
	echo "a) Setup all"
	echo "q) Exit"
        read -r -p "What option do you choose? " input

        case $input in
	    [1])
		dependencies
                ;;
	    [2])
		gitConf
                ;;
	    [3])
		terminalApplication
                ;;
	    [4])
		emacs
                ;;
	    [5])
		vscode
                ;;
	    [6])
		zoom
                ;;
	    [7])
		rclone
                ;;
	    [8])
		backlighting
                ;;
	    [9])
		flutter
                ;;
	    [aA])
		setupAll
                ;;
            [qQ])
                break
                ;;
            *)
		echo "Invalid input..."
		;;
        esac
    done
}

echo $SCRIPT_DIR
menu
