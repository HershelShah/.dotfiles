--------------------------------------------------------------------------------
-- @file settings.lua
-- @author Hershel Shah
-- @brief Neovim settings
--------------------------------------------------------------------------------
local set = vim.opt

--------------------------------------------------------------------------------
-- Window Options
--------------------------------------------------------------------------------
-- Split Below or Right
set.splitbelow = true
set.splitright = true
-- Disable Wrap-around
set.wrap = false
-- Show Additional Lines
set.scrolloff = 10
-- Enable Terminal GUI Colors
set.termguicolors = true
-- Enable Relative Number
set.relativenumber = true
-- Enable Number
set.number = true
-- Enable Cursorline
set.cursorline = true
-- Enable hidden buffers
set.hidden = true
-- UTF-8 Encoding
set.fileencoding = 'utf-8'
-- Set Complete Options
set.completeopt = 'menuone,noselect'
-- Set Clipboard
set.clipboard = 'unnamedplus'

--------------------------------------------------------------------------------
-- Tab Options
--------------------------------------------------------------------------------
-- Width of Tab in Spaces
set.tabstop = 4
-- Size of an Indent
set.shiftwidth = 4
-- Expands Tabs to Spaces
set.expandtab = true
-- Enable Smart Tabbing
set.smarttab = true

--------------------------------------------------------------------------------
-- Search Options
--------------------------------------------------------------------------------
-- Enable Highlight Search
set.hlsearch = true
-- Enable Incremental Search
set.incsearch = true
-- Enable Ignore Case
set.ignorecase = true
-- Enable Smart Case
set.smartcase = true

