#! /bin/bash
#
# Installation and setup for OpenSUSE


#script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

requiring_manual_action_end_messages=()
commands=(
    "Setup ZSH"
    "Setup flatpak"
    "Setup Latex"
    "Setup OpenSCAD"
    "Setup KiCAD"
    "Setup VSCode (latex, openscad)"
    "Setup Virtualbox"
    "Setup Docker"
    "Setup Kind (docker)"
    "Setup GIMP"
    "Setup Cura (flatpak)"
    "Setup AATTS"
    "Run all commands"
    "Exit"
)

#######################################
# Prints messages in requiring_manual_action_end_messages
# Globals:
#   requiring_manual_action_end_messages
# Arguments:
#   None
# Outputs:
#   Messages in requiring_manual_action_end_messages
#######################################
print_messages() {
    echo "Messages:"
    for message in "${messages[@]}"; do
        echo "$message"
    done
}

#######################################
# Add message to requiring_manual_action_end_messages
# Globals:
#   requiring_manual_action_end_messages
# Arguments:
#   Message to add
# Outputs:
#   None
#######################################
add_message() {
    requiring_manual_action_end_messages+=("$1")
}


#######################################
# Prompt user with [Y/n] opten for provided question
# Globals:
#   None
# Arguments:
#   Question to promt
#   Command to run for [Y] response
#   Command to run for [n] response
# Outputs:
#   Prompts
#######################################
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


#######################################
#   Welcome message
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Welcome message
#######################################
welcome() {
    echo '
    Fedora installation script

    '
    prompt "Do you wish to proceed?" 'echo "proceeding..."' 'exit 0'
}


##############################################################################
########################  Installation and setup #############################
##############################################################################

setup_git() {
    if [[ -n "$(git config user.name)" ]]; then
        echo "Exiting from the function"
        return
    fi

    read -r -p "\nGit email: " gitEmail
    read -r -p "Git name: " gitName

    prompt "Configure with $gitEmail and $gitName" $(echo "git configured") $(exit 0)

    sudo -u $USER git config --global user.email $gitEmail
    sudo -u $USER git config --global user.name $gitName
    
    add_message "Generate keys and add keys to GitHub account"
}

dependencies() {
    sudo zypper update 
    sudo zypper install git
    mkdir -p $HOME/Programs/

    setup_git
}

setup_zsh() {
    sudo zypper install zsh lf

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
}

setup_flatpak() {
    sudo zypper install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    add_message "Reboot before installing flatpak packages"
}

setup_latex() {
    sudo zypper install texlive-latex
}

setup_openscad() {
    sudo zypper install openscad
}

setup_kicad() {
    sudo zypper addrepo https://download.opensuse.org/repositories/electronics/openSUSE_Tumbleweed/electronics.repo
    sudo zypper refresh
    sudo zypper install kicad
}

setup_vscode() {
    sudo zypper install code

    # VS_Code extensions
    code --install-extension vscodevim.vim
    code --install-extension james-yu.latex-workshop
    code --install-extension hediet.vscode-drawio
    code --install-extension golang.go
    code --install-extension valentjn.vscode-ltex
    code --install-extension wayou.vscode-todo-highlight 
    code --install-extension antyos.openscad 

    # https://github.com/VSCodeVim/Vim
    # User/settings
    #"vim.useSystemClipboard": true,
}

setup_virtualbox() {
    sudo zypper update
    sudo zypper install virtualbox
    sudo gpasswd -a $USER vboxusers
}

setup_docker() {
    sudo zypper install docker docker-compose docker-compose-switch
    sudo systemctl enable docker
    sudo usermod -G docker -a $USER
    newgrp docker
    sudo systemctl restart docker
    sudo systemctl start docker
}

setup_kind() {
    #   https://kind.sigs.k8s.io/docs/user/quick-start/
    #   https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64

    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind

    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    kubectl version --client
}

setup_gimp() {
    sudo zypper install gimp
}

setup_cura() {
    #   https://flathub.org/apps/com.ultimaker.cura
    sudo flatpak install flathub com.ultimaker.cura
}

setup_tts() {
    git clone git@github.com:Anton-Augustsson/tts.git $HOME/Programs/tts/
    make -C $HOME/Programs/tts/
}

##############################################################################
##########################  To run the scripts  ##############################
##############################################################################

#######################################
#   Display a menu of the avalible commands
# Globals:
#   commands
# Arguments:
#   None
# Outputs:
#   the avalible commands
#######################################
display_menu() {
    echo "Menu:"
    for ((i=0; i<${#commands[@]}; i++)); do
        echo "$((i+1)). ${commands[$i]}"
    done
}

#######################################
#   Execute the selected commands
# Globals:
#   commands
# Arguments:
#   None
# Outputs:
#   None
#######################################
execute_commands() {
    selected_indices=($@)
    for index in "${selected_indices[@]}"; do
        case $index in
            1 )
                echo "${commands[$index - 1]}"
                setup_zsh
                ;;
            2 )
                echo "${commands[$index - 1]}"
                setup_flatpak
                ;;
            3 )
                echo "${commands[$index - 1]}"
                setup_latex
                ;;
            4 )
                echo "${commands[$index - 1]}"
                setup_openscad
                ;;
            5 )
                echo "${commands[$index - 1]}"
                setup_kicad
                ;;
            6 )
                echo "${commands[$index - 1]}"
                setup_vscode
                ;;
            7 )
                echo "${commands[$index - 1]}"
                setup_virtualbox
                ;;
            8 )
                echo "${commands[$index - 1]}"
                setup_docker
                ;;
            9 )
                echo "${commands[$index - 1]}"
                setup_kind
                ;;
            10 )
                echo "${commands[$index - 1]}"
                setup_gimp
                ;;
            11 )
                echo "${commands[$index - 1]}"
                setup_cura
                ;;
            12 )
                echo "${commands[$index - 1]}"
                setup_tts
                ;;
            13 )
                echo "${commands[$index - 1]}"
                setup_zsh
                setup_flatpak
                setup_latex
                setup_openscad
                setup_kicad
                setup_vscode
                setup_virtualbox
                setup_docker
                setup_kind
                setup_gimp
                setup_cura
                setup_tts
                ;;
            14 )
                echo "Exiting..."
                exit
                ;;
            * )
                echo "Invalid selection."
                ;;
        esac
    done
}

welcome
dependencies
while true; do
    display_menu

    read -rp "Enter your choice (comma-separated numbers, 'a' for all, 'q' to quit): " choice

    case $choice in
        [0-9]* )
            IFS=',' read -ra selected <<< "$choice"
            execute_commands "${selected[@]}"
            ;;
        "a" )
            execute_commands $(seq 1 ${#commands[@]})
            ;;
        "q" )
            echo "Exiting..."
            exit
            ;;
        * )
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac

    echo
done
print_messages
