local builtin = require('telescope.builtin')
local fb_actions = require("telescope._extensions.file_browser.actions")

-- Telescope Key Map Configurations
-- File Pickers
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>gs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})

-- Vim Pickers
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>c', builtin.commands, {})
vim.keymap.set('n', '<leader>t', builtin.tags, {})
vim.keymap.set('n', '<leader>ch', builtin.command_history, {})
vim.keymap.set('n', '<leader>sh', builtin.search_history, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>mp', builtin.man_pages, {})
vim.keymap.set('n', '<leader>m', builtin.marks, {})
vim.keymap.set('n', '<leader>qf', builtin.quickfix, {})
vim.keymap.set('n', '<leader>qfh', builtin.quickfixhistory, {})
vim.keymap.set('n', '<leader>ll', builtin.loclist, {})
vim.keymap.set('n', '<leader>jl', builtin.jumplist, {})
vim.keymap.set('n', '<leader>vo', builtin.vim_options, {})
vim.keymap.set('n', '<leader>r', builtin.registers, {})
vim.keymap.set('n', '<leader>a', builtin.autocommands, {})
vim.keymap.set('n', '<leader>ss', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>k', builtin.keymaps, {})
vim.keymap.set('n', '<leader>ft', builtin.filetypes, {})
vim.keymap.set('n', '<leader>hi', builtin.highlights, {})
vim.keymap.set('n', '<leader>cbf', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>cbt', builtin.current_buffer_tags, {})
vim.keymap.set('n', '<leader>r', builtin.resume, {})
vim.keymap.set('n', '<leader>p', builtin.pickers, {})

-- Git Pickers
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gbc', builtin.git_bcommits, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gss', builtin.git_status, {})
vim.keymap.set('n', '<leader>gst', builtin.git_stash, {})

-- Treesitter Picker
vim.keymap.set('n', '<leader>t', builtin.treesitter, {})
