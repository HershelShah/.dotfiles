--------------------------------------------------------------------------------
-- @file filesitter-config/init.lua
-- @author Hershel Shah
-- @brief Treesitter Configurations
--------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or 'all'
    ensure_installed = {
        'cuda',
        'help',
        'bash', 
        'c', 
        'cpp',
        'lua',
        'python',
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    auto_install = true,

    -- List of parsers to ignore installing (for 'all')
    ignore_install = { },

    highlight = { enable = true, },
}
