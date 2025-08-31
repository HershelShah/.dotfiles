local opt = vim.opt
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.signcolumn = "yes"

require("config.lazy")
require("config.autocmds")
