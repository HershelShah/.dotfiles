----------------------------------------------------------------------------------
-- @file packer.lua
-- @author Hershel Shah
-- @brief Load Packer Modules
----------------------------------------------------------------------------------

return require('packer').startup(function()
    -- Packer Pacakge Manager
    use 'wbthomason/packer.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-telescope/telescope-file-browser.nvim',
        }
    }

    -- Colorschemes
    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd.colorscheme('rose-pine')
        end
    }

    -- Tree Sitter Syntax
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Comment Plugin
    use { 'numToStr/Comment.nvim' }

    -- Notify
    use { 'rcarriga/nvim-notify' }

    -- Undotree
    use { 'mbbill/undotree' }

    -- Buffer Manager
    use {
        'romgrk/barbar.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Neovim Window Picker
    use {
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
    }

    -- Dashboard
    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup({
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = ' Apps',
                            group = 'DiagnosticHint',
                            action = 'Telescope app',
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
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }

    -- Autopairs
    use {
        'windwp/nvim-autopairs',
    }

    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
    }

    use({
        "kylechui/nvim-surround",
        tag = "*",
    })

    -- -- Neovim Session Management System
    -- use({
    --     'olimorris/persisted.nvim',
    --     config = function()
    --         require('persisted').setup({
    --             autoload = true,
    --             on_autoload_no_session = function()
    --                 vim.notify("No existing session to load.")
    --             end,
    --             should_autosave = function()
    --                 if vim.bo.filetype == "dashboard" or vim.bo.filetype == "bool" then
    --                     return false
    --                 end
    --                 return true
    --             end,
    --             command = "VimLeavePre",
    --             use_git_branch = true,
    --         })
    --         require('telescope').load_extension('persisted')
    --     end,
    -- })
    --
    --
    -- -- LSP Plugins
    -- use {
    --     'williamboman/mason.nvim',
    --     config = function()
    --         require('mason').setup({
    --             ui = {
    --                 icons = {
    --                     package_installed = "✓",
    --                     package_pending = "➜",
    --                     package_uninstalled = "✗"
    --                 }
    --             }
    --         })
    --     end
    -- }
    --
    -- -- Mason
    -- use {
    --     'williamboman/mason-lspconfig.nvim',
    --     config = function()
    --         require('mason-lspconfig').setup()
    --     end
    -- }
    --
    -- -- Configurations for Nvim LSP
    -- use 'neovim/nvim-lspconfig'
    --
    -- -- Autocompletion plugin
    -- use 'hrsh7th/nvim-cmp'
    --
    -- -- LSP source for nvim-cmp
    -- use 'hrsh7th/cmp-nvim-lsp'
    --
    -- -- Buffer source for nvim-cmp
    -- use 'hrsh7th/cmp-buffer'
    --
    -- -- Path source for nvim-cmp
    -- use 'hrsh7th/cmp-path'
    --
    -- -- CMD line source for nvim-cmp
    -- use 'hrsh7th/cmp-cmdline'
    --
    -- -- LUA Snips Autocomplete
    -- use 'saadparwaiz1/cmp_luasnip'
    -- use 'L3MON4D3/LuaSnip'
    -- use 'rafamadriz/friendly-snippets'
    --
    -- -- LSP Signature
    -- use {
    --     'ray-x/lsp_signature.nvim',
    --     config = function()
    --         require('lsp_signature').setup({})
    --     end
    -- }
    --
    -- -- Adds Pictograms to LSP
    -- use 'onsails/lspkind.nvim'
    --
    -- -- Preview Window
    -- use {
    --     'rmagatti/goto-preview',
    --     config = function()
    --         require('goto-preview').setup({})
    --     end
    -- }
    --
    -- -- Add Tagbar
    -- use 'preservim/tagbar'
    --
    -- -- Focus Window Manager
    -- use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }
    --
    -- use {
    --     'phaazon/mind.nvim',
    --     branch = 'v2.2',
    --     requires = { 'nvim-lua/plenary.nvim' },
    --     config = function()
    --         require('mind').setup({})
    --     end
    -- }
    --
    -- -- Document Generation
    -- use {
    --     "danymat/neogen",
    --     config = function()
    --         require('neogen').setup({})
    --     end,
    --     requires = { 'nvim-treesitter/nvim-treesitter' },
    --     -- Uncomment next line if you want to follow only stable versions
    --     -- tag = "*"
    -- }
    --
    --
    -- -- Surround.nvim
    -- use({
    --     "kylechui/nvim-surround",
    --     tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    --     config = function()
    --         require("nvim-surround").setup({})
    --     end
    -- })
end)
