# shellcheck disable=SC2148

# Run Neofetch if available
command -v neofetch >/dev/null && neofetch

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Disable oh-my-zsh theme; Starship handles the prompt
# shellcheck disable=SC2034
ZSH_THEME=""

# Plugins
# shellcheck disable=SC2034
plugins=(
    colored-man-pages
    colorize
    dircycle
    dirpersist
    docker
    fzf
    git
    git-auto-fetch
    jsontools
    sudo
    web-search
    z
    zsh-autosuggestions
    zsh-interactive-cd
    zsh-syntax-highlighting
)

# Load Oh My Zsh
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  # shellcheck disable=SC1091
  source "$ZSH/oh-my-zsh.sh"
fi

# Initialize Starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# User configuration
export EDITOR='nvim'
alias vim='nvim'

alias get_lx106='export PATH="$PATH:$HOME/esp/xtensa-lx106-elf/bin"; export IDF_PATH=$HOME/esp/ESP8266_RTOS_SDK'

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
  # shellcheck disable=SC1091
  . "$NVM_DIR/bash_completion"
fi

# Add Cargo to PATH
export PATH="$HOME/.cargo/bin:$PATH"

