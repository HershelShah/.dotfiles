### Setup

1. Clone this repository into `~/.dotfiles`.
2. Run `./install.sh` to install required packages, Oh My Zsh plugins, and the Starship prompt.
3. From the repository root run `stow .` to symlink the configuration files.

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin
management and requires Neovim 0.9 or newer. The terminal prompt is powered by
[Starship](https://starship.rs) and configured via `.config/starship.toml`.
