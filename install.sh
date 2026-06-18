#!/usr/bin/env bash
# Install dotfiles: symlink configs + install missing tools
# Usage:
#   ./install.sh            # symlink dotfiles + install tools
#   ./install.sh --no-link  # install tools only, skip symlinks (configs already in place)
#   ./install.sh --update   # update git-cloned plugins and tools
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"
NO_LINK=false
UPDATE=false
for arg in "$@"; do
  case "$arg" in
    --no-link) NO_LINK=true ;;
    --update)  UPDATE=true ;;
  esac
done

need() { ! command -v "$1" >/dev/null 2>&1; }

# Need to (re)install neovim? True if missing OR older than 0.12 — the
# main-branch nvim-treesitter config requires nightly, so an existing stable
# nvim must still be upgraded.
need_nvim() {
  command -v nvim >/dev/null 2>&1 || return 0
  ! nvim --headless --noplugin -u NONE \
      -c "lua os.exit(vim.fn.has('nvim-0.12') == 1 and 0 or 1)" -c "qa" 2>/dev/null
}

OS="$(uname -s)"  # Linux | Darwin

# --- Symlinks ---
if [[ "$NO_LINK" == false ]]; then
  link() {
    local src="$DOTFILES/$1" dest="$HOME/$1"
    # Back up a real (non-symlink) target so we never destroy an existing config.
    if [[ -e "$dest" && ! -L "$dest" ]]; then
      local bak="$dest.bak-$(date +%Y%m%d%H%M%S)"
      echo "  backing up $dest -> $bak"
      mv "$dest" "$bak"
    fi
    rm -rf "$dest"  # only ever removes a symlink now
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

if [[ "$OS" == "Darwin" ]]; then
  # macOS: use Homebrew
  if need brew; then
    echo "[install] Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Make brew available in the current script after a fresh install
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  pkgs=()
  need starship  && pkgs+=(starship)
  # NOTE: brew installs stable neovim; the main-branch treesitter config needs
  # 0.12 nightly — on macOS run `brew install neovim --HEAD` if treesitter breaks.
  need nvim         && pkgs+=(neovim)
  need tree-sitter  && pkgs+=(tree-sitter)
  need fzf       && pkgs+=(fzf)
  need fnm       && pkgs+=(fnm)
  need rg        && pkgs+=(ripgrep)
  need fd        && pkgs+=(fd)
  need bat       && pkgs+=(bat)
  need delta     && pkgs+=(git-delta)
  need zoxide    && pkgs+=(zoxide)
  need eza       && pkgs+=(eza)
  need lazygit   && pkgs+=(lazygit)
  need tmux      && pkgs+=(tmux)
  need sesh      && pkgs+=(sesh)
  need direnv    && pkgs+=(direnv)
  need gh        && pkgs+=(gh)

  if [[ ${#pkgs[@]} -gt 0 ]]; then
    echo "[install] ${pkgs[*]}..."
    brew install "${pkgs[@]}"
  fi


else
  # Linux: pre-built binaries downloaded to ~/.local/bin
  mkdir -p "$BIN_DIR"
  PATH="$BIN_DIR:$HOME/.fzf/bin:$PATH"

  # Detect architecture
  UARCH="$(uname -m)"
  case "$UARCH" in
    x86_64)          ARCH="x86_64" ;;
    aarch64|arm64)   ARCH="aarch64" ;;
    *)               echo "[error] Unsupported architecture: $UARCH"; exit 1 ;;
  esac

  for cmd in git curl; do
    if need "$cmd"; then
      echo "[error] $cmd is required. Install it with your package manager."
      exit 1
    fi
  done

  # Helper: get latest GitHub release tag (non-zero on failure, e.g. rate limit)
  gh_latest() {
    local tag
    tag=$(curl -sSf "https://api.github.com/repos/$1/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)
    if [[ -z "$tag" ]]; then
      echo "[warn] could not fetch latest release for $1 (rate limited?)" >&2
      return 1
    fi
    printf '%s\n' "$tag"
  }

  # Helper: download and extract a binary from a GitHub release tarball.
  # No-strip case extracts to a temp dir and moves only the binary, so extra
  # files (completions/, man/, LICENSE) never pollute $BIN_DIR and a nested or
  # missing binary is caught instead of silently leaving the tool off PATH.
  gh_tar() {
    local bin="$1" url="$2" strip="${3:-0}"
    echo "[install] $bin..."
    if [[ "$strip" -gt 0 ]]; then
      curl -sSfL "$url" | tar xz --strip-components="$strip" -C "$BIN_DIR" --wildcards "*/$bin"
    else
      local tmp found
      tmp=$(mktemp -d)
      curl -sSfL "$url" | tar xz -C "$tmp"
      found=$(find "$tmp" -type f -name "$bin" -print -quit)
      if [[ -z "$found" ]]; then
        echo "[error] $bin not found in tarball" >&2
        rm -rf "$tmp"
        return 1
      fi
      mv "$found" "$BIN_DIR/$bin"
      chmod +x "$BIN_DIR/$bin"
      rm -rf "$tmp"
    fi
  }

  if need starship; then
    echo "[install] starship..."
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$BIN_DIR"
  fi

  if need_nvim; then
    echo "[install] neovim (nightly)..."
    # nightly (0.12) is required by the main-branch nvim-treesitter config
    nvim_arch="x86_64"
    [[ "$ARCH" == "aarch64" ]] && nvim_arch="arm64"
    curl -sSfL "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-${nvim_arch}.tar.gz" \
      | tar xz -C "$HOME/.local"
    ln -sf "$HOME/.local/nvim-linux-${nvim_arch}/bin/nvim" "$BIN_DIR/nvim"
  fi

  if need fzf; then
    echo "[install] fzf..."
    git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --bin --no-update-rc --no-bash --no-zsh --no-fish
  fi

  if need fnm; then
    echo "[install] fnm..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$BIN_DIR" --skip-shell
  fi

  # Each block folds the release lookup into the guard: a failed gh_latest
  # (e.g. GitHub rate limit) skips just that tool instead of aborting the run.
  if need rg && v=$(gh_latest BurntSushi/ripgrep); then
    gh_tar rg "https://github.com/BurntSushi/ripgrep/releases/download/${v}/ripgrep-${v}-${ARCH}-unknown-linux-musl.tar.gz" 1 || echo "[warn] rg install failed" >&2
  fi
  if need fd && v=$(gh_latest sharkdp/fd); then
    gh_tar fd "https://github.com/sharkdp/fd/releases/download/${v}/fd-${v}-${ARCH}-unknown-linux-musl.tar.gz" 1 || echo "[warn] fd install failed" >&2
  fi
  if need bat && v=$(gh_latest sharkdp/bat); then
    gh_tar bat "https://github.com/sharkdp/bat/releases/download/${v}/bat-${v}-${ARCH}-unknown-linux-musl.tar.gz" 1 || echo "[warn] bat install failed" >&2
  fi
  if need delta && v=$(gh_latest dandavison/delta); then
    gh_tar delta "https://github.com/dandavison/delta/releases/download/${v}/delta-${v}-${ARCH}-unknown-linux-musl.tar.gz" 1 || echo "[warn] delta install failed" >&2
  fi
  if need zoxide && v=$(gh_latest ajeetdsouza/zoxide); then
    vn="${v#v}"
    gh_tar zoxide "https://github.com/ajeetdsouza/zoxide/releases/download/${v}/zoxide-${vn}-${ARCH}-unknown-linux-musl.tar.gz" || echo "[warn] zoxide install failed" >&2
  fi
  if need eza && v=$(gh_latest eza-community/eza); then
    gh_tar eza "https://github.com/eza-community/eza/releases/download/${v}/eza_${ARCH}-unknown-linux-musl.tar.gz" || echo "[warn] eza install failed" >&2
  fi
  if need lazygit && v=$(gh_latest jesseduffield/lazygit); then
    vn="${v#v}"
    lg_arch="x86_64"
    [[ "$ARCH" == "aarch64" ]] && lg_arch="arm64"
    gh_tar lazygit "https://github.com/jesseduffield/lazygit/releases/download/${v}/lazygit_${vn}_linux_${lg_arch}.tar.gz" || echo "[warn] lazygit install failed" >&2
  fi
  if need sesh && v=$(gh_latest joshmedeski/sesh); then
    sesh_arch="x86_64"
    [[ "$ARCH" == "aarch64" ]] && sesh_arch="arm64"
    gh_tar sesh "https://github.com/joshmedeski/sesh/releases/download/${v}/sesh_Linux_${sesh_arch}.tar.gz" || echo "[warn] sesh install failed" >&2
  fi
  if need direnv && v=$(gh_latest direnv/direnv); then
    direnv_arch="amd64"
    [[ "$ARCH" == "aarch64" ]] && direnv_arch="arm64"
    echo "[install] direnv..."
    if curl -sSfL "https://github.com/direnv/direnv/releases/download/${v}/direnv.linux-${direnv_arch}" -o "$BIN_DIR/direnv"; then
      chmod +x "$BIN_DIR/direnv"
    else
      echo "[warn] direnv install failed" >&2
    fi
  fi
  if need gh && v=$(gh_latest cli/cli); then
    vn="${v#v}"
    gh_arch="amd64"
    [[ "$ARCH" == "aarch64" ]] && gh_arch="arm64"
    gh_tar gh "https://github.com/cli/cli/releases/download/${v}/gh_${vn}_linux_${gh_arch}.tar.gz" 2 || echo "[warn] gh install failed" >&2
  fi
  # tree-sitter CLI: required by the main-branch nvim-treesitter to build parsers
  if need tree-sitter && v=$(gh_latest tree-sitter/tree-sitter); then
    ts_arch="x64"
    [[ "$ARCH" == "aarch64" ]] && ts_arch="arm64"
    echo "[install] tree-sitter..."
    if curl -sSfL "https://github.com/tree-sitter/tree-sitter/releases/download/${v}/tree-sitter-linux-${ts_arch}.gz" -o "$BIN_DIR/tree-sitter.gz" \
       && gzip -df "$BIN_DIR/tree-sitter.gz"; then
      chmod +x "$BIN_DIR/tree-sitter"
    else
      echo "[warn] tree-sitter install failed" >&2
      rm -f "$BIN_DIR/tree-sitter.gz" "$BIN_DIR/tree-sitter"
    fi
  fi
fi

# Claude Code (install script handles OS/arch internally)
if need claude; then
  echo "[install] Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi

# fzf-git.sh
if [[ ! -d "$HOME/.fzf-git.sh" ]]; then
  echo "[install] fzf-git.sh..."
  git clone --depth=1 https://github.com/junegunn/fzf-git.sh.git "$HOME/.fzf-git.sh"
fi

# Zsh plugins
ZSH_PLUGINS="$HOME/.zsh/plugins"
clone_plugin() {
  local name="$1" url="$2"
  if [[ ! -d "$ZSH_PLUGINS/$name" ]]; then
    echo "[install] $name..."
    mkdir -p "$ZSH_PLUGINS"
    git clone --depth=1 "$url" "$ZSH_PLUGINS/$name"
  fi
}
clone_plugin zsh-autosuggestions     https://github.com/zsh-users/zsh-autosuggestions.git
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
clone_plugin fzf-tab                 https://github.com/Aloxaf/fzf-tab.git

# Compile all configured tree-sitter parsers synchronously so a fresh setup is
# fully provisioned up front (the plugin otherwise installs them lazily on first
# file open). Blocks until done; errors are non-fatal.
ts_install_parsers() {
  echo "[install] treesitter parsers..."
  nvim --headless -c "lua require('nvim-treesitter').install(require('config.ts_parsers')):wait(600000)" +qa \
    || echo "[warn] treesitter parser install had errors — run :TSInstall in nvim" >&2
}

# Neovim plugins (headless sync)
if command -v nvim >/dev/null 2>&1; then
  echo "[install] neovim plugins..."
  nvim --headless "+Lazy! sync" +qa || echo "[warn] neovim plugin sync had errors — run :Lazy sync in nvim" >&2
  ts_install_parsers
fi

# Node LTS via fnm
if command -v fnm >/dev/null 2>&1 && [[ -z "$(fnm ls 2>/dev/null | grep -v system || true)" ]]; then
  echo "[install] node (LTS via fnm)..."
  fnm install --lts
fi

# --- Update git-cloned plugins ---
if [[ "$UPDATE" == true ]]; then
  echo ""
  echo "Updating git-cloned plugins..."
  pull_update() {
    local dir="$1" name="$2"
    if [[ -d "$dir" ]]; then
      echo "[update] $name..."
      git -C "$dir" fetch --depth=1 origin
      git -C "$dir" reset --hard origin/HEAD
    fi
  }
  pull_update "$HOME/.fzf"           "fzf"
  pull_update "$HOME/.fzf-git.sh"    "fzf-git.sh"
  pull_update "$ZSH_PLUGINS/zsh-autosuggestions"     "zsh-autosuggestions"
  pull_update "$ZSH_PLUGINS/zsh-syntax-highlighting" "zsh-syntax-highlighting"
  pull_update "$ZSH_PLUGINS/fzf-tab"                 "fzf-tab"

  # Re-sync neovim plugins
  if command -v nvim >/dev/null 2>&1; then
    echo "[update] neovim plugins..."
    nvim --headless "+Lazy! sync" +qa || echo "[warn] neovim plugin sync had errors — run :Lazy sync in nvim" >&2
    ts_install_parsers
  fi
fi

echo ""
echo "Done. Start a new zsh shell to activate."
