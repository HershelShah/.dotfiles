--------------------------------------------------------------------------------
-- @file init.lua
-- @author Hershel Shah
-- @brief Load all lua modules for Neovim
--------------------------------------------------------------------------------
require('packer-config')
require('settings')
require('mappings')
require('colorschemes-config.dracula')
require('nvim-tree-config')
require('lsp-config.language-servers')
-- require('lsp-config.nvim-cmp')
require('lualine-config')
require('treesitter-config')
require('dashboard-config')
require('telescope-config')
