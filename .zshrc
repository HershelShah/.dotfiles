# shellcheck disable=SC2148

# Run Neofetch if available
command -v neofetch >/dev/null && neofetch

# Powerlevel10k instant prompt
# shellcheck disable=SC1090,SC2296
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # shellcheck disable=SC1090,SC2296
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
# shellcheck disable=SC2034
ZSH_THEME="powerlevel10k/powerlevel10k"

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

# User configuration
export EDITOR='nvim'
alias vim='nvim'

alias get_lx106='export PATH="$PATH:$HOME/esp/xtensa-lx106-elf/bin"; export IDF_PATH=$HOME/esp/ESP8266_RTOS_SDK'

# Powerlevel10k configuration
if [[ -f ~/.p10k.zsh ]]; then
  # shellcheck disable=SC1090
  source ~/.p10k.zsh
fi

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

