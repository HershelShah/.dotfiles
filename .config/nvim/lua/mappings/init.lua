--------------------------------------------------------------------------------
-- @file mappings/init.lua
-- @author Hershel Shah
-- @brief Keymap of Shortcuts
--------------------------------------------------------------------------------
-- Set map and other common options
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Set Leader to Space
vim.g.mapleader = ' '

-- Toggle Nvim Tree Toggle
map('n', '<C-f>', ':NvimTreeToggle<CR>', default_opts)

-- Barbar Mappings
-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', default_opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', default_opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', default_opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', default_opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', default_opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', default_opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', default_opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', default_opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', default_opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', default_opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', default_opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', default_opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', default_opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', default_opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', default_opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', default_opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', default_opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', default_opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', default_opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', default_opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', default_opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- Telescope Configurations
map('n', '<leader>ff', ':Telescope find_files<CR>', default_opts)
map('n', '<leader>fw', ':Telescope live_grep<CR>', default_opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', default_opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', default_opts)
