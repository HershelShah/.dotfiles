# Cheatsheet

Discovery shortcuts (use these first):

- **In nvim**: press `<leader>` (Space) and wait — `mini.clue` lists every leader keymap
- **In tmux**: `prefix + ?` lists every tmux binding
- **In any shell**: `cheat` (alias) or `prefix + h` (tmux popup) opens this file

---

## tmux

Prefix is `C-Space`.

### Sessions / windows / panes

| Key | Action |
|---|---|
| `prefix s` | **sesh** popup (tmux sessions + zoxide dirs + ~/.config/sesh/sesh.toml) |
| `prefix S` | plain tmux session picker (fallback) |
| `prefix d` | detach |
| `prefix c` | new window |
| `prefix ,` | rename window |
| `prefix 0-9` | jump to window N |
| `prefix w` | window picker |
| `prefix &` | kill window |
| `M-H` / `M-L` | prev/next window (no prefix) |
| `prefix "` | split horizontal (keeps cwd) |
| `prefix %` | split vertical (keeps cwd) |
| `prefix arrow` | move between panes |
| `prefix z` | zoom/unzoom pane |
| `prefix space` | cycle pane layout |
| `prefix x` | kill pane |
| `prefix { } ` | swap pane prev/next |
| `prefix r` | reload `~/.tmux.conf` |
| `prefix h` | open this cheatsheet |

### Copy mode (vi keys)

| Key | Action |
|---|---|
| `prefix [` | enter copy mode |
| `v` | begin selection |
| `C-v` | toggle rectangle selection |
| `y` | copy + exit |
| `q` | exit |
| `/` `?` | search forward / back |

---

## zsh / shell

### Modern CLI aliases

| Alias | Command |
|---|---|
| `g` | `git` |
| `ll` | `eza -la --icons --git` |
| `tree` | `eza --tree --icons` |
| `lg` | `lazygit` |
| `vim` | `nvim` |
| `..` `...` `....` | `cd ..` / `../..` / `../../..` |
| `cheat` | open this cheatsheet |

### Built-in zsh tricks

| Key / cmd | Action |
|---|---|
| `Esc Esc` | toggle `sudo` prefix on current line |
| `cd -<Tab>` | jump to recent dir (AUTO_PUSHD) |
| bare `path/` | implicit `cd` (AUTO_CD) |
| `Tab` on `.foo` | dotfile completion (GLOB_DOTS) |

### zoxide (smarter cd)

| Cmd | Action |
|---|---|
| `z foo` | jump to most-frecent dir matching `foo` |
| `zi` | interactive picker (fzf) |
| `z ..` | parent |
| `z -` | previous dir |

### direnv

| Cmd | Action |
|---|---|
| `direnv allow` | trust `.envrc` in current dir |
| `direnv reload` | re-evaluate `.envrc` |
| `direnv edit` | edit `.envrc` and auto-allow |

---

## fzf (shell)

| Key | Action |
|---|---|
| `C-t` | insert file path (preview via bat) |
| `C-r` | search shell history |
| `M-c` | cd into dir |
| `**<Tab>` | trigger fzf completion (e.g. `vim **<Tab>`) |

### Inside any fzf prompt

| Key | Action |
|---|---|
| `C-j` `C-k` | next / prev |
| `Tab` | multi-select |
| `C-/` | toggle preview |
| `C-y` | copy selection |

### fzf-git (`C-g` prefix)

| Key | Action |
|---|---|
| `C-g C-f` | files |
| `C-g C-b` | branches |
| `C-g C-t` | tags |
| `C-g C-r` | remotes |
| `C-g C-h` | commit hashes |
| `C-g C-s` | stashes |
| `C-g C-l` | reflog |
| `C-g C-w` | worktrees |
| `C-g C-e` | each-ref |

---

## nvim — leader groups

Leader is `<Space>`. Press leader and wait to see groups.

| Group | Meaning |
|---|---|
| `<leader>a` | +claude |
| `<leader>f` | +find |
| `<leader>g` | +git |
| `<leader>h` | +hunk |
| `<leader>l` | +lsp |
| `<leader>m` | +mini |
| `<leader>n` / `<leader>p` | +swap next / prev |
| `<leader>r` | +rename / restart |
| `<leader>t` | +toggle |

### General

| Key | Action |
|---|---|
| `<leader>w` / `C-s` | save |
| `<leader>q` | quit |
| `<leader>x` | delete buffer (keeps window) |
| `<leader>e` | file explorer at current file |
| `<leader>E` | file explorer at cwd |
| `<Esc>` | clear search highlight |
| `C-h/j/k/l` | window nav |
| `v < / >` | indent + reselect |

### Find (fzf-lua)

| Key | Action |
|---|---|
| `<leader>ff` | find files |
| `<leader>fg` | live grep |
| `<leader>fb` | buffers |
| `<leader>fh` | help tags |
| `<leader>gb` | git branches |
| `<leader>gc` | git commits |

### LSP

| Key | Action |
|---|---|
| `K` | hover docs |
| `gd` | definitions |
| `gD` | declarations |
| `gi` | implementations |
| `gt` | type definitions |
| `gR` | references |
| `gra` | code actions |
| `grn` | rename symbol |
| `<C-W>d` | diagnostic float |
| `<leader>ls` / `<leader>lS` | doc / workspace symbols |
| `<leader>D` | buffer diagnostics |
| `<leader>dw` | workspace diagnostics |
| `<leader>lf` | format buffer (conform) |
| `<leader>lh` | switch source/header (clangd) |
| `<leader>th` | toggle inlay hints |
| `<leader>rs` | restart LSP |

### Diagnostics navigation

| Key | Action |
|---|---|
| `]d` / `[d` | next / prev diagnostic |
| `<leader>tt` | Trouble — diagnostics view |
| `<leader>ts` | Trouble — symbols outline |

### Git hunks (gitsigns)

| Key | Action |
|---|---|
| `]h` / `[h` | next / prev hunk |
| `<leader>hp` | preview hunk |
| `<leader>hs` | stage hunk (or range in visual) |
| `<leader>hr` | reset hunk |
| `<leader>hu` | undo stage hunk |
| `<leader>hS` | stage buffer |
| `<leader>hR` | reset buffer |
| `<leader>hb` | blame line (full) |
| `<leader>hd` | diff this |
| `<leader>td` | toggle deleted lines |

### Claude (claudecode.nvim)

`claude` CLI auto-discovers nvim via lock file — just run it in any tmux pane.

| Key | Action |
|---|---|
| `<leader>ac` | toggle claude terminal in nvim |
| `<leader>af` | focus claude |
| `<leader>ar` | resume previous session |
| `<leader>aC` | continue last session |
| `<leader>am` | select model |
| `<leader>ab` | add current buffer to context |
| `<leader>as` (visual) | send selection |
| `<leader>aa` | accept diff |
| `<leader>ad` | deny diff |

### Treesitter — incremental selection

| Key | Action |
|---|---|
| `<C-space>` | start / expand selection by node |
| `<BS>` | shrink selection |

### Treesitter — text objects (visual/operator, e.g. `va=`, `dim`)

| Key | Region |
|---|---|
| `a=` `i=` | assignment outer / inner |
| `l=` `r=` | assignment LHS / RHS |
| `aa` `ia` | parameter / argument |
| `af` `if` | function call |
| `am` `im` | method / function definition |
| `ac` `ic` | class |
| `ai` `ii` | conditional |
| `al` `il` | loop |

### Treesitter — motions

| Key | Target |
|---|---|
| `]f` `[f` | function call start |
| `]F` `[F` | function call end |
| `]m` `[m` | function def start |
| `]M` `[M` | function def end |
| `]c` `[c` | class start |
| `]C` `[C` | class end |
| `]i` `[i` | conditional start |
| `]l` `[l` | loop start |
| `]s` | scope |
| `]z` | fold |

### Treesitter — swap

| Key | Action |
|---|---|
| `<leader>na` / `<leader>pa` | swap parameter next / prev |
| `<leader>nm` / `<leader>pm` | swap function next / prev |

### mini.nvim

| Key | Action |
|---|---|
| `sa{motion}{char}` | surround add (e.g. `saiw"` wraps word in `"`) |
| `sd{char}` | surround delete |
| `sr{old}{new}` | surround replace |
| `gS` | splitjoin: toggle single ↔ multi-line |
| `M-h/j/k/l` | move line / selection |
| `<leader>mm` | toggle minimap |
| `<leader>tw` | trim trailing whitespace |

### blink.cmp (completion, in insert mode)

| Key | Action |
|---|---|
| `<C-Space>` | show completion |
| `<C-j>` `<C-k>` | next / prev item |
| `<C-b>` `<C-f>` | scroll docs |
| `<CR>` | accept |
| `<C-e>` | cancel |

---

## Built-in vim niceties worth remembering

| Key | Action |
|---|---|
| `.` | repeat last change |
| `*` `#` | search word under cursor (forward / back) |
| `%` | jump to matching bracket |
| `g;` `g,` | jump to last edit / forward |
| `''` | jump to last position in file |
| `<C-o>` `<C-i>` | jump list back / forward |
| `q{a-z}` … `q` | record macro to register |
| `@a` | replay macro `a` |
| `ciw` `daw` | change inner word / delete around word |
| `:%s/foo/bar/g` | replace (live preview via `inccommand=split`) |
| `[b` `]b` | prev / next buffer (built-in nvim 0.11) |
| `[d` `]d` | prev / next diagnostic |
| `[q` `]q` | prev / next quickfix |

---

## git aliases (`~/.gitconfig`)

| Alias | Expands to |
|---|---|
| `git s` | `status -sb` |
| `git co` | `checkout` |
| `git cb` | `checkout -b` |
| `git lg` | `log --oneline --graph --decorate -20` |
| `git unstage` | `reset HEAD --` |
| `git last` | `log -1 HEAD --stat` |

Modern defaults set: `pull.rebase`, `push.autoSetupRemote`, `fetch.prune`,
`rerere.enabled`, `branch.sort=-committerdate`, `diff.algorithm=histogram`,
`rebase.autosquash`. So `git pull` rebases, `git push` auto-tracks, fixup
commits auto-squash, conflict resolutions are remembered.
