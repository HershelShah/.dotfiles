#!/usr/bin/env bash
set -euo pipefail

# Install packages using apt-get if available
if command -v apt-get >/dev/null 2>&1; then
  packages=(zsh git stow neovim curl neofetch fzf)
  missing=()
  for pkg in "${packages[@]}"; do
    dpkg -s "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
  done
  if [ "${#missing[@]}" -gt 0 ]; then
    sudo apt-get update
    sudo apt-get install -y "${missing[@]}"
  fi
fi

# Install Oh My Zsh if not present
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
if [ ! -d "$ZSH" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [ ! -d "$ZSH/custom/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH/custom/themes/powerlevel10k"
fi

# Install required plugins
plugins_dir="$ZSH/custom/plugins"
mkdir -p "$plugins_dir"

declare -A plugins=(
  [zsh-autosuggestions]=https://github.com/zsh-users/zsh-autosuggestions.git
  [zsh-syntax-highlighting]=https://github.com/zsh-users/zsh-syntax-highlighting.git
  [zsh-interactive-cd]=https://github.com/zsh-users/zsh-interactive-cd.git
)

for name in "${!plugins[@]}"; do
  if [ ! -d "$plugins_dir/$name" ]; then
    git clone --depth=1 "${plugins[$name]}" "$plugins_dir/$name"
  fi
done

echo "All dependencies installed."
