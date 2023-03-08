----------------------------------------------------------------------------------
-- @file dashboard.lua
-- @author Hershel Shah
-- @brief Load Dashboard
----------------------------------------------------------------------------------
require('dashboard').setup({
    theme = 'hyper',
    config = {
        week_header = {
            enable = true,
        },
        shortcut = {
            { desc = ' Update', group = '@property', action = 'PackerSync', key = 'u' },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                desc = ' Sessions',
                group = 'DiagnosticHint',
                action = 'Telescope persisted',
                key = 'a',
            },
            {
                desc = ' dotfiles',
                group = 'Number',
                action = 'Telescope dotfiles',
                key = 'd',
            },
        },
    },
})
