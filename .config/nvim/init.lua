--------------------------------------------------------------------------------
-- @file init.lua
-- @author Hershel Shah
-- @brief Load all lua modules for Neovim
--------------------------------------------------------------------------------
require('packer-config')
require('settings')
require('mappings')
require('dashboard-config')
require('lualine-config')
require('lsp-config.language-servers')
require('lsp-config.nvim-cmp')
require('nvim-tree-config')
require('treesitter-config')
require('telescope-config')
