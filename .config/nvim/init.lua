-- Options
local opt = vim.opt
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.signcolumn = "yes"

-- Bootstrap plugin manager, set leader, load plugins
require("config.lazy")

-- Autocommands and keymaps (loaded after plugins so mini.* is available)
require("config.autocmds")
require("config.keymaps")
