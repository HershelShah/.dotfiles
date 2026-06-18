# Dotfiles

Personal dotfiles managing neovim, tmux, zsh, kitty, starship, and git configs.

## Structure

- `install.sh` — idempotent installer: symlinks configs + installs tools
  - `--no-link` skips symlinks (when configs are already at their target paths; the Dockerfile runs the linking install instead)
  - `--update` pulls latest for git-cloned plugins
- `.config/nvim/` — Neovim config (lazy.nvim, requires nvim 0.11+)
- `.config/kitty/` — Kitty terminal config (Tokyo Night theme)
- `.config/starship.toml` — Starship prompt
- `.tmux.conf` — tmux config (prefix: C-Space, tpm for plugins)
- `.zshrc` — zsh config (no framework, direct plugin sourcing)
- `.gitconfig` — git config (delta pager, zdiff3 merge)

## Testing changes

- Test install.sh in Docker: `docker build -t dotfiles . && docker run -it dotfiles`
- Test without symlinks: `./install.sh --no-link`
- Neovim health: `:checkhealth` after changes
