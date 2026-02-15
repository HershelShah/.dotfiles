#!/usr/bin/env bash
# Install dotfiles: symlink configs + install missing tools
# Usage:
#   ./install.sh            # symlink dotfiles + install tools
#   ./install.sh --no-link  # install tools only (for Docker)
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"
NO_LINK=false
[[ "${1:-}" == "--no-link" ]] && NO_LINK=true

need() { ! command -v "$1" >/dev/null 2>&1; }

# Detect platform for binary downloads
ARCH="$(uname -m)"
case "$ARCH" in
  x86_64)  ARCH_RUST="x86_64-unknown-linux-musl"; ARCH_GO="Linux_x86_64" ;;
  aarch64) ARCH_RUST="aarch64-unknown-linux-musl"; ARCH_GO="Linux_arm64" ;;
  *) echo "[error] Unsupported architecture: $ARCH"; exit 1 ;;
esac

# --- Symlinks ---
if [[ "$NO_LINK" == false ]]; then
  link() {
    local src="$DOTFILES/$1" dest="$HOME/$1"
    rm -rf $dest
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "  $1 -> $src"
  }
  echo "Linking dotfiles from $DOTFILES"
  link .zshrc
  link .tmux.conf
  link .gitconfig
  link .config/nvim
  link .config/starship.toml
  link .config/kitty
  link .config/git
  link .claude/settings.local.json
  echo ""
fi

# --- Tool installation ---
echo "Checking tools..."

mkdir -p "$BIN_DIR"
PATH="$BIN_DIR:$HOME/.fzf/bin:$PATH"

for cmd in git curl; do
  if need "$cmd"; then
    echo "[error] $cmd is required. Install it with your package manager."
    exit 1
  fi
done

# Helper: get latest GitHub release tag
gh_latest() {
  curl -sSf "https://api.github.com/repos/$1/releases/latest" | grep '"tag_name"' | cut -d'"' -f4
}

# Helper: download and extract a binary from a GitHub release tarball
gh_tar() {
  local bin="$1" url="$2" strip="${3:-0}"
  echo "[install] $bin..."
  if [[ "$strip" -gt 0 ]]; then
    curl -sSfL "$url" | tar xz --strip-components="$strip" -C "$BIN_DIR" --wildcards "*/$bin"
  else
    curl -sSfL "$url" | tar xz -C "$BIN_DIR"
  fi
}

# Starship
if need starship; then
  echo "[install] starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$BIN_DIR"
fi

# Neovim
if need nvim; then
  echo "[install] neovim..."
  curl -sSfL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz" \
    | tar xz -C "$HOME/.local"
  ln -sf "$HOME/.local/nvim-linux-x86_64/bin/nvim" "$BIN_DIR/nvim"
fi

# fzf
if need fzf; then
  echo "[install] fzf..."
  git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --bin --no-update-rc --no-bash --no-zsh --no-fish
fi

# fnm (fast node manager)
if need fnm; then
  echo "[install] fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$BIN_DIR" --skip-shell
fi

# Pre-built binaries (version-resolved via GitHub API, no cargo needed)
if need rg; then
  v=$(gh_latest BurntSushi/ripgrep)
  gh_tar rg "https://github.com/BurntSushi/ripgrep/releases/download/${v}/ripgrep-${v}-${ARCH_RUST}.tar.gz" 1
fi
if need fd; then
  v=$(gh_latest sharkdp/fd)
  gh_tar fd "https://github.com/sharkdp/fd/releases/download/${v}/fd-${v}-${ARCH_RUST}.tar.gz" 1
fi
if need bat; then
  v=$(gh_latest sharkdp/bat)
  gh_tar bat "https://github.com/sharkdp/bat/releases/download/${v}/bat-${v}-${ARCH_RUST}.tar.gz" 1
fi
if need delta; then
  v=$(gh_latest dandavison/delta)
  gh_tar delta "https://github.com/dandavison/delta/releases/download/${v}/delta-${v}-${ARCH_RUST}.tar.gz" 1
fi
if need zoxide; then
  v=$(gh_latest ajeetdsouza/zoxide); vn="${v#v}"
  gh_tar zoxide "https://github.com/ajeetdsouza/zoxide/releases/download/${v}/zoxide-${vn}-${ARCH_RUST}.tar.gz"
fi
if need eza; then
  v=$(gh_latest eza-community/eza)
  gh_tar eza "https://github.com/eza-community/eza/releases/download/${v}/eza_${ARCH_RUST}.tar.gz"
fi
if need lazygit; then
  v=$(gh_latest jesseduffield/lazygit); vn="${v#v}"
  gh_tar lazygit "https://github.com/jesseduffield/lazygit/releases/download/${v}/lazygit_${vn}_${ARCH_GO}.tar.gz"
fi

# Claude Code
if need claude; then
  echo "[install] Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi

# fzf-git.sh (git object picker keybindings)
if [[ ! -d "$HOME/.fzf-git.sh" ]]; then
  echo "[install] fzf-git.sh..."
  git clone --depth=1 https://github.com/junegunn/fzf-git.sh.git "$HOME/.fzf-git.sh"
fi

# Zsh plugins
ZSH_PLUGINS="$HOME/.zsh/plugins"
declare -A plugin_repos=(
  [zsh-autosuggestions]=https://github.com/zsh-users/zsh-autosuggestions.git
  [zsh-syntax-highlighting]=https://github.com/zsh-users/zsh-syntax-highlighting.git
  [fzf-tab]=https://github.com/Aloxaf/fzf-tab.git
)
for name in "${!plugin_repos[@]}"; do
  if [[ ! -d "$ZSH_PLUGINS/$name" ]]; then
    echo "[install] $name..."
    mkdir -p "$ZSH_PLUGINS"
    git clone --depth=1 "${plugin_repos[$name]}" "$ZSH_PLUGINS/$name"
  fi
done

# Neovim plugins (headless sync)
if command -v nvim >/dev/null 2>&1; then
  echo "[install] neovim plugins..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
fi

# Node LTS via fnm
if command -v fnm >/dev/null 2>&1 && [[ -z "$(fnm ls 2>/dev/null | grep -v system || true)" ]]; then
  echo "[install] node (LTS via fnm)..."
  fnm install --lts
fi

echo ""
echo "Done. Start a new zsh shell to activate."
