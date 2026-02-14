### Setup

1. Clone this repository into `~/.dotfiles`.
2. Run `./install.sh` to symlink configs and install tools.
3. Open a new zsh shell.

### Codespaces

**As your dotfiles repo (any Codespace):**
Go to [Settings > Codespaces > Dotfiles](https://github.com/settings/codespaces), select this repo, and set the install command to `./install.sh --no-link`. Your tools and shell config will be applied to every Codespace automatically.

**As a standalone dev environment:**
Open this repo in a Codespace — the devcontainer builds from the Dockerfile with everything pre-installed.

### Docker

```
docker build -t dotfiles . && docker run -it dotfiles
```

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin
management and requires Neovim 0.11 or newer.
