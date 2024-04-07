#! /bin/bash
#
# Installation and setup for OpenSUSE


#script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

requiring_manual_action_end_messages=()
commands=(
    "Setup Git"
    "Setup ZSH"
    "Setup VSCode"
    "Setup VSCode"
    "Setup Docker"
    "Setup OpenSCAD"
    "Setup KiCAD"
    "Setup Latex"
    "Setup LF"
    "Setup GIMP"
    "Setup Cura"
    "Setup Virtualbox"
    "Setup Kind"
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
    prompt "Do you wish to proceed?" $(echo "proceeding...") $(exit 0)
}

#######################################
#   Set the git email and user name.
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Inputs for email and name
#######################################
gitConf() {
    read -r -p "\nGit email: " gitEmail
    read -r -p "Git name: " gitName

    prompt "Confinnue with $gitEmail and $gitNme" $(echo "confinuing") $(exit 0)

    sudo -u $USER git config --global user.email $gitEmail
    sudo -u $USER git config --global user.name $gitName
    
    add_message "Generate keys and add keys to GitHub account"
}

#######################################
#   Some general dependencies
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
#######################################
dependencies() {
    sudo zypper update
    mkdir $HOME/Programs/
}

#######################################
#   Setup zsh
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
#######################################
terminalApplication() {
    sudo zypper install zsh

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

#######################################
#   Setup VSCode
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
#######################################
vscode() {
    sudo zypper install code openscad texlive-latex

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

#######################################
#   Install AATTS
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
#######################################
tts() {
    git clone git@github.com:Anton-Augustsson/tts.git $HOME/Programs/tts/
    make -C $HOME/Programs/tts/
}

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
                setup_git_command
                ;;
            2 )
                echo "${commands[$index - 1]}"
                setup_zsh_command
                ;;
            3 )
                echo "${commands[$index - 1]}"
                setup_vscode_command
                ;;
            4 )
                echo "${commands[$index - 1]}"
                setup_docker_command
                ;;
            5 )
                echo "${commands[$index - 1]}"
                setup_openscad_command
                ;;
            6 )
                echo "${commands[$index - 1]}"
                setup_kicad_command
                ;;
            7 )
                echo "${commands[$index - 1]}"
                setup_latex_command
                ;;
            8 )
                echo "${commands[$index - 1]}"
                setup_lf_command
                ;;
            9 )
                echo "${commands[$index - 1]}"
                setup_gimp_command
                ;;
            10 )
                echo "${commands[$index - 1]}"
                setup_cura_command
                ;;
            11 )
                echo "${commands[$index - 1]}"
                setup_virtualbox_command
                ;;
            12 )
                echo "${commands[$index - 1]}"
                setup_kind_command
                ;;
            13 )
                echo "${commands[$index - 1]}"
                run_all_commands
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
