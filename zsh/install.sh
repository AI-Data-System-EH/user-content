#!/bin/bash

# File: zsh/install.sh

# /bin/bash -c "./zsh/install.sh --reinstall --gh-token ~/mytoken.txt"

# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --deps-only
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --no-gh
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --gh-token <token>
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --install-deps --gh-token <token>

# Useradd example
# with permission
# sudo useradd -m -s /bin/bash -G sudo <username>
# without permission
# sudo useradd -m -s /bin/bash <username>

# Arguments
# --username          : GitHub username
# --email             : GitHub email (ID+USERNAME@users.noreply.github.com)
# --no-omz | --no-zsh : Skip Oh-My-Zsh installation
# --no-ssh            : Skip SSH key generation
# --no-git            : Skip Git configuration
# --no-gh             : Skip GitHub CLI configuration
# --ssh-key-path      : SSH key path (default: ~/.ssh/id_ed25519) (no .pub extension)
# --gh-token          : GitHub CLI Personal Access Token (classic). (Scope: repo, read:org, gist, user, admin:public_key, admin:ssh_signing_key)
# --gh-skip-ssh-key   : Skip adding SSH key to GitHub
# --install-deps      : Install system package dependencies (requires permission)
# --deps-only         : Install system package dependencies only (no user-specific configurations)
# --help, -h          : Show help message
# --yes, -y           : Skip user confirmation
# --reinstall         : Reinstall all configurations

################################# Colorize #####################################
# pretty print
PURPLE='\033[0;95m'
CYAN='\033[0;96m'
LIME='\033[38;5;154m'
LIGHT_GRAY='\033[38;5;242m'
RED='\033[0;31m'
YELLOW_BOLD_UNDERLINE='\033[1;4;33m'

NC='\033[0m' # No Color

colorize() { # $1: color, $2: text
    case $1 in
    main)
        echo -e "\n${CYAN}$2${NC}\n"
        ;;
    info)
        echo -e "${PURPLE}$2${NC}"
        ;;
    log)
        echo -e "${LIGHT_GRAY}$2${NC}"
        ;;
    success)
        echo -e "${LIME}$2${NC}"
        ;;
    ask)
        printf "${LIGHT_GRAY}$2${NC}"
        ;;
    warning)
        echo -e "${YELLOW_BOLD_UNDERLINE}$2${NC}"
        ;;
    error)
        echo -e "${RED}$2${NC}"
        ;;
    *)
        echo "$2"
        ;;
    esac
}

################################# Functions ##################################

help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --username <username>    : Git username (fetch from GitHub if not provided)"
    echo "  --email <email>          : Git email (fetch from GitHub if not provided)"
    echo "  --no-omz | --no-zsh      : Skip Oh-My-Zsh installation"
    echo "  --no-ssh                 : Skip SSH key generation"
    echo "  --no-git                 : Skip Git configuration"
    echo "  --no-gh                  : Skip GitHub CLI configuration"
    echo "  --ssh-key-path <path>    : SSH key path (default: ~/.ssh/id_ed25519) (no .pub extension)"
    echo "  --gh-token <token>       : GitHub CLI Personal Access Token (classic) (file path or token string)"
    echo "  --gh-skip-ssh-key        : Skip adding SSH key to GitHub"
    echo "  --install-deps           : Install system package dependencies (requires permission)"
    echo "  --deps-only              : Install system package dependencies only (no user-specific configurations)"
    echo "  --help, -h               : Show help message"
    echo "  --yes, -y                : Skip user confirmation"
    echo "  --reinstall              : Reinstall all configurations"
}

#################################### ARG #######################################

# Default values
GIT_USERNAME=""
GIT_EMAIL=""

INSTALL_OMZ=true
INSTALL_SSH=true
INSTALL_GIT=true
INSTALL_GH=true

USER_HOME=$(eval echo ~$(whoami))
INSTALL_DEPS=false
DEPS_ONLY=false
SKIP_CONFIRM=false
REINSTALL=false

SSH_KEY_PATH="$USER_HOME/.ssh/id_ed25519"
GH_TOKEN=""
GH_SKIP_SSH_KEY=false

# Parse arguments
# available argument pass style:
# --username <username>
# --username=<username>
# --username="<username>"
# --username='<username>'

while [ $# -gt 0 ]; do
    case "$1" in
    --help | -h)
        help
        exit 0
        ;;
    --username)
        GIT_USERNAME="$2"
        shift 2
        ;;
    --username=*)
        GIT_USERNAME="${1#--username=}"
        shift
        ;;
    --email)
        GIT_EMAIL="$2"
        shift 2
        ;;
    --email=*)
        GIT_EMAIL="${1#--email=}"
        shift
        ;;
    --no-omz | --no-zsh)
        INSTALL_OMZ=false
        shift
        ;;
    --no-ssh)
        INSTALL_SSH=false
        shift
        ;;
    --no-git)
        INSTALL_GIT=false
        shift
        ;;
    --no-gh)
        INSTALL_GH=false
        shift
        ;;
    --ssh-key-path)
        SSH_KEY_PATH="$2"
        shift 2
        ;;
    --ssh-key-path=*)
        SSH_KEY_PATH="${1#--ssh-key-path=}"
        shift
        ;;
    --gh-token)
        GH_TOKEN="$2"
        shift 2
        ;;
    --gh-token=*)
        GH_TOKEN="${1#--gh-token=}"
        shift
        ;;
    --gh-skip-ssh-key)
        GH_SKIP_SSH_KEY=true
        shift
        ;;
    --yes | -y)
        SKIP_CONFIRM=true
        shift
        ;;
    --install-deps)
        INSTALL_DEPS=true
        shift
        ;;
    --deps-only)
        DEPS_ONLY=true
        INSTALL_DEPS=true
        shift
        ;;
    --reinstall)
        REINSTALL=true
        shift
        ;;
    *)
        echo "Unknown argument: $1"
        exit 1
        ;;
    esac
done

############################# Check Prerequisites ##############################

# Check OS (Debian/Ubuntu Linux/Darwin)
if [[ "$(uname)" != "Linux" && "$(uname)" != "Darwin" ]]; then
    colorize error "This script is only for Debian/Ubuntu Linux and macOS. Aborting."
    colorize info "Current system: $(uname)"
    exit 1
fi

# Check sudo command
if [ "$INSTALL_DEPS" = true ] && ! command -v sudo &>/dev/null; then
    colorize error "sudo command not found. Aborting."
    colorize info "Please install sudo first and run the script again."
    exit 1
fi

SSH_KEY_PATH=$(eval echo $SSH_KEY_PATH)

if [ "$INSTALL_GH" = false ]; then
    GH_SKIP_SSH_KEY=true
fi

# Check arguments
colorize main "CHECK YOUR INSTALLATION"
colorize log "-----------------------------------------------"
colorize log "Script       : $0"
colorize log "OS           : $(uname)"
colorize log "Current User : $(whoami)"
colorize log "User home    : $USER_HOME"
colorize log "-----------------------------------------------"
colorize log "Skip install confirm        : $SKIP_CONFIRM"
colorize log "Install System Dependencies : $INSTALL_DEPS"
colorize log "Install Dependencies Only   : $DEPS_ONLY"
colorize log "-----------------------------------------------"
if [ $DEPS_ONLY = true ]; then
    colorize log "Install zsh          : $INSTALL_OMZ"
    colorize log "Install GitHub CLI   : $INSTALL_GH"
    colorize log "-----------------------------------------------"
else
    colorize log "Git User     : ${GIT_USERNAME:-"Not provided"}"
    colorize log "Git Email    : ${GIT_EMAIL:-"Not provided"}"
    colorize log "-----------------------------------------------"
    colorize log "SSH key path : $SSH_KEY_PATH"
    colorize log "GitHub Token : $([ -n "$GH_TOKEN" ] && echo 'Provided' || echo 'Not provided')"
    colorize log "SSH key add to GitHub  : $([ "$GH_SKIP_SSH_KEY" = true ] && echo 'No' || echo 'Yes')"
    colorize log "-----------------------------------------------"
    colorize log "Install Oh-My-Zsh    : $INSTALL_OMZ"
    colorize log "Generate SSH key     : $INSTALL_SSH"
    colorize log "Configure GitHub CLI : $INSTALL_GH"
    colorize log "Configure Git        : $INSTALL_GIT"
    colorize log "-----------------------------------------------"
    colorize log "Force reinstall      : $REINSTALL"
    colorize log "-----------------------------------------------"
fi

# Check environment variables
colorize main "LOCAL ENVIRONMENT VARIABLES"
colorize log "-----------------------------------------------"
colorize log "USER                : $USER"
colorize log "HOME                : $HOME"
colorize log "HOSTNAME            : $HOSTNAME"
colorize log "SHELL               : $SHELL"
colorize log "ZSH                 : $ZSH"
colorize log "ZSH_CUSTOM          : $ZSH_CUSTOM"
colorize log "-----------------------------------------------"

# User confirmation
if [ "$SKIP_CONFIRM" = false ]; then
    read -p "Do you want to continue with the installation? ([y]/N): " -n 1 -r
    echo # print user input

    # Check user input : [Y/y/return] for yes, [Others] for no
    if [[ ! $REPLY =~ ^[Yy]$ && ! -z $REPLY ]]; then
        colorize error "Installation aborted."
        exit 1
    fi
fi

################### Install System Dependencies (with sudo) ####################
if [ "$INSTALL_DEPS" = true ]; then
    colorize main "Install: System Dependencies (with sudo)"

    # Check sudo permission (passwd)
    if ! sudo -v; then
        colorize warning "$(whoami) does not have sudo permission."
        colorize info "Run script as admin user or remove '--install-deps' or '--deps-only' flag."
        colorize info "If you don't have sudo permission, please contact your system administrator."

        colorize error "You must have sudo privileges to install dependencies."
        exit 1
    fi

    # Basic dependencies (for script)
    if [ "$(uname)" = "Linux" ]; then
        colorize info "[apt] Installing dependencies..."
        sudo apt-get update && sudo apt-get install -y curl openssh-client jq wget git --no-install-recommends

        # Install zsh & ruby for colorls
        if [ "$INSTALL_OMZ" = true ]; then
            sudo apt-get install -y zsh nano build-essential ruby-dev --no-install-recommends
            sudo gem install colorls
            gem cleanup
        fi

        colorize success "[apt] Dependencies installed successfully."

    elif [ "$(uname)" = "Darwin" ]; then
        # Homebrew does not recommend running as sudo
        colorize info "[brew] Installing dependencies..."

        # Install Homebrew
        if ! command -v brew &>/dev/null; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            # Add Homebrew to PATH
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$USER_HOME/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        # Install dependencies
        brew install curl openssh jq wget git

        # Install ruby for colorls
        if [ "$INSTALL_OMZ" = true ]; then
            brew install zsh nano ruby
            gem install colorls
            gem cleanup
        fi

        colorize success "[brew] Dependencies installed successfully."
    fi

    # gh cli installation executes only if gh is not installed
    if ! command -v gh &>/dev/null && [ "$INSTALL_GH" = true ]; then
        colorize info "Installing GitHub CLI..."

        # Install GitHub CLI based on OS
        if [ "$(uname)" = "Darwin" ]; then
            (command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)") &&
                brew install gh
        elif [ "$(uname)" = "Linux" ]; then
            # https://github.com/cli/cli/blob/trunk/docs/install_linux.md#official-sources
            (type -p wget >/dev/null || (sudo apt-get update && sudo apt-get install wget -y)) &&
                sudo mkdir -p -m 755 /etc/apt/keyrings &&
                out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg &&
                cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
                sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
                sudo apt-get update &&
                sudo apt-get install gh -y
        fi
        colorize success "GitHub CLI installed successfully."
    fi

fi

if [ "$DEPS_ONLY" = true ]; then
    colorize main "Dependencies Installed."
    colorize info "Please run the script with flags to complete the user installation."
    colorize log "We recommend running the script as a regular user without '--install-deps' or '--deps-only' flag."
    exit 0
fi

############################ Install Oh-My-Zsh #################################
if [ "$INSTALL_OMZ" = true ]; then
    colorize main "Install: Oh-My-Zsh"

    ZSH="$USER_HOME/.oh-my-zsh"
    ZSH_CUSTOM="$USER_HOME/.oh-my-zsh/custom"

    # Remove existing Oh-My-Zsh
    if [ -d "$USER_HOME/.oh-my-zsh" ] && [ "$REINSTALL" = true ]; then
        colorize warning "Removing existing Oh-My-Zsh to reinstall."
        rm -rf "$USER_HOME/.oh-my-zsh"
        rm -rf "$USER_HOME/.fzf" "$USER_HOME/.fzf.zsh"
        rm -rf "$USER_HOME/.zshrc" "$USER_HOME/.p10k.zsh"
        colorize success "Existing Oh-My-Zsh configuration removed."
    fi

    if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
        colorize info "Installing Oh-My-Zsh..."

        # Install Oh-My-Zsh
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        colorize log "Oh-My-Zsh installation completed."

        # Install Powerlevel10k theme and plugins
        git clone --depth=1 https://github.com/romkatv/powerlevel10k ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/zsh-completions
        git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
        git clone --recursive --depth 1 https://github.com/mattmc3/zsh-safe-rm ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/zsh-safe-rm
        git clone https://github.com/fdellwing/zsh-bat ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/zsh-bat
        git clone https://github.com/gretzky/auto-color-ls ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/auto-color-ls
        git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}/plugins/autoupdate

        # Install fzf
        git clone --depth 1 https://github.com/junegunn/fzf $USER_HOME/.fzf
        $USER_HOME/.fzf/install --all --no-fish --no-bash --no-update-rc

        # Copy .zshrc and .p10k.zsh from remote repository
        curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/.zshrc -o $USER_HOME/.zshrc
        curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/.p10k.zsh -o $USER_HOME/.p10k.zsh
        colorize log "Zsh configuration files fetched from remote repository."

        colorize success "Oh-My-Zsh installation completed."
    else
        colorize info "Oh-My-Zsh already installed. Skipping installation."
    fi

fi

############################# Install SSH Key ##################################
if [ "$INSTALL_SSH" = true ]; then
    colorize main "Install: SSH key"

    if ! [ -f "$SSH_KEY_PATH" ] || [ "$REINSTALL" = true ]; then
        # Generate SSH key (will overwrite existing key, no prompt)
        # rm -f "$SSH_KEY_PATH" "$SSH_KEY_PATH.pub"
        mv "$SSH_KEY_PATH" "$SSH_KEY_PATH.bak" >/dev/null 2>&1
        mv "$SSH_KEY_PATH.pub" "$SSH_KEY_PATH.pub.bak" >/dev/null 2>&1

        ssh-keygen -t ed25519 -f "$SSH_KEY_PATH" -q -N "" >/dev/null 2>&1
        colorize success "SSH key generated successfully."

        # Preview SSH key
        colorize log "Here is your New SSH public key:"
        colorize log "$(cat "$SSH_KEY_PATH.pub")"

        # Adding SSH key to ssh-agent will be automatically handled by zshrc(ssh-agent plugin)
        # remove existing ssh-key from ssh-agent
        if [ "$REINSTALL" = true ]; then
            # suppress ssh-add output message
            ssh-add -D >/dev/null 2>&1
        fi
    else
        colorize info "SSH key already exists. Skipping generation."
        colorize log "$(cat "$SSH_KEY_PATH.pub")"
    fi

fi

########################### Install GitHub CLI #################################
if [ "$INSTALL_GH" = true ]; then
    colorize main "Install: GitHub CLI"

    # Configure GitHub CLI
    # https://cli.github.com/manual/gh_auth_login

    # Get token string from file if $GH_TOKEN provided as file path
    if [ -f "$GH_TOKEN" ]; then
        GH_TOKEN=$(cat "$GH_TOKEN")
    fi

    if [ -z "$GH_TOKEN" ]; then
        colorize error "GitHub CLI requires a Personal Access Token (classic) to authenticate."
        colorize log "Please provide a Personal Access Token (classic) with the following scopes:"
        colorize log "    repo, read:org, gist, user, admin:public_key, admin:ssh_signing_key"
        colorize info "Go to https://github.com/settings/tokens to create a token."
    else
        colorize info "Configuring GitHub CLI..."

        # Set GitHub CLI host and login with token
        gh config set --host github.com git_protocol ssh
        echo "$GH_TOKEN" | gh auth login --git-protocol=ssh --skip-ssh-key --with-token
        unset GH_TOKEN

        if [ "$GH_SKIP_SSH_KEY" = false ] && [ -f "$SSH_KEY_PATH.pub" ]; then
            colorize info "Adding SSH key(authentication,signing) to GitHub..."

            # Add SSH key to GitHub
            gh ssh-key add "$SSH_KEY_PATH.pub" --title "$(whoami)@$(hostname)" --type "authentication"
            gh ssh-key add "$SSH_KEY_PATH.pub" --title "$(whoami)@$(hostname)" --type "signing"
            colorize success "SSH key added to GitHub successfully."

            colorize info "To verify your SSH key, you can run 'gh ssh-key list'."
            colorize log "You can also check your SSH key in GitHub settings."
            colorize log "    GitHub link: https://github.com/settings/keys"
        fi

        colorize success "GitHub CLI configured successfully."
    fi

fi

############################# Configure Git ####################################
if [ "$INSTALL_GIT" = true ]; then
    colorize main "Install: Git Configuration"

    # Check gh login status (only if $INSTALL_GH = true)
    if [ "$INSTALL_GH" = true ]; then
        if ! gh auth status &>/dev/null; then
            colorize warning "GitHub CLI is not configured."
            colorize info "Please reconfigure git manually with the following commands:"
            colorize log "    Git Username : git config --global user.name <github username>"
            colorize log "    Git Email    : git config --global user.email <github email>"
        else
            colorize info "Fetching GitHub credentials..."

            GH_USERNAME="$(gh api user | jq -r '.login')"
            if [ -z "$GIT_USERNAME" ]; then
                GIT_USERNAME="$GH_USERNAME"
            fi

            GH_USERID="$(gh api user | jq -r '.id')"
            GH_EMAIL="$(gh api user 2>/dev/null | jq -r '.email // empty')"
            if [ -z "$GH_EMAIL" ]; then # if empty email (if checked 'Keep my email addresses private' in GitHub)
                # Use default email (ID+USERNAME@users.noreply.github.com)
                GH_EMAIL="${GH_USERID:-0}+${GH_USERNAME:-unknown}@users.noreply.github.com"
            fi

            if [ -z "$GIT_EMAIL" ]; then
                GIT_EMAIL="$GH_EMAIL"
            fi
        fi
    fi

    # Set user.name and user.email if provided
    if [ -z "$GIT_USERNAME" ] || [ -z "$GIT_EMAIL" ]; then
        git config --global user.name "$GIT_USERNAME"
        git config --global user.email "$GIT_EMAIL"
    fi

    # Configure Git for GitHub Verified Commit
    git config --global gpg.format ssh
    git config --global gpg.ssh.defaultKeyCommand "ssh-add -L"
    git config --global commit.gpgsign true

    colorize info "Verifying Git configuration..."
    colorize log "Git Username   : $(git config --global user.name)"
    colorize log "Git Email      : $(git config --global user.email)"
    colorize log "Git GPG Sign   : $(git config --global commit.gpgsign)"
    colorize log "Git GPG Key    : $(git config --global gpg.ssh.defaultKeyCommand)"
    colorize log "Git GPG Format : $(git config --global gpg.format)"

    # "git.enableCommitSigning": true (VSCode)
    colorize info "We recommend enabling 'git.enableCommitSigning' in VSCode settings."
    colorize log "To enable it, add the following to your settings.json:"
    colorize log "    \"git.enableCommitSigning\": true"

    colorize success "Git configuration complete."
fi

######################### Finalize Installation ################################
colorize main "Installation Completed"
colorize log "------------------------------------------------------------------------"
colorize info "To apply the changes, please restart your terminal or run 'exec zsh'."
colorize log "You can manually change the default shell with the following command:"
colorize log "    chsh -s $(which zsh)"
colorize log "------------------------------------------------------------------------"
colorize log "For more information, please visit the following links:"
colorize log "    Oh-My-Zsh  : https://ohmyz.sh/"
colorize log "    GitHub CLI : https://cli.github.com/"
colorize log "    Git        : https://git-scm.com/"
colorize log "------------------------------------------------------------------------"
