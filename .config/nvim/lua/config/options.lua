-- Editor options. Loaded before plugins (init.lua requires this first).
local opt = vim.opt

-- Indent (default; per-filetype overrides in autocmds.lua)
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Line numbers + sign column
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1" -- lock width so gitsigns + diagnostics don't shift columns
opt.cursorline = true

-- Search
opt.ignorecase = true
opt.smartcase = true -- case-insensitive unless capital is typed
opt.inccommand = "split" -- live preview of :%s/foo/bar

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Edit
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.confirm = true -- :q on unsaved buffer prompts instead of erroring
opt.virtualedit = "block" -- visual-block can extend past EOL

-- UX
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true
opt.updatetime = 250 -- faster CursorHold (LSP hover, gitsigns)
opt.timeoutlen = 300 -- snappier mini.clue / multi-key sequences
opt.laststatus = 3 -- single global statusline across splits
