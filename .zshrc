# --- Zsh core settings ---
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE HIST_VERIFY SHARE_HISTORY
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS
bindkey -e

# Completions (regenerate cache once daily)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Colored man pages (replaces OMZ colored-man-pages)
export LESS_TERMCAP_mb=$'\e[1;31m' LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'    LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_se=$'\e[0m'    LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# Sudo with Esc-Esc (replaces OMZ sudo plugin)
sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  if [[ $BUFFER == sudo\ * ]]; then
    LBUFFER="${LBUFFER#sudo }"
  else
    LBUFFER="sudo $LBUFFER"
  fi
}
zle -N sudo-command-line
bindkey '\e\e' sudo-command-line

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.fzf/bin:$PATH"

# --- Plugins (sourced directly, no framework) ---
ZSH_PLUGINS="$HOME/.zsh/plugins"
[[ -f "$ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh" ]] && source "$ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh"
[[ -f "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# fzf keybindings and completion
[[ -f "$HOME/.fzf/shell/key-bindings.zsh" ]] && source "$HOME/.fzf/shell/key-bindings.zsh"
[[ -f "$HOME/.fzf/shell/completion.zsh" ]] && source "$HOME/.fzf/shell/completion.zsh"

# fzf-git.sh keybindings (Ctrl-G + Ctrl-F/B/T/R/H/S/L/W/E)
[[ -f "$HOME/.fzf-git.sh/fzf-git.sh" ]] && source "$HOME/.fzf-git.sh/fzf-git.sh"

# --- User configuration ---
export EDITOR='nvim'
alias vim='nvim'

# Modern CLI aliases
command -v bat >/dev/null 2>&1 && alias cat='bat --paging=never'
command -v eza >/dev/null 2>&1 && alias ls='eza --icons' && alias ll='eza -la --icons --git' && alias tree='eza --tree --icons'
alias lg='lazygit'

# Use fd and bat with fzf when available
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
fi
command -v bat >/dev/null 2>&1 && export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# fnm (fast node manager)
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi

# Zoxide (smarter cd)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# Starship prompt (must be last)
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Warn if key tools are missing
for _cmd in nvim starship fzf zoxide; do
  command -v "$_cmd" >/dev/null 2>&1 || echo "[warn] $_cmd not found — run ~/.dotfiles/install.sh"
done
unset _cmd
