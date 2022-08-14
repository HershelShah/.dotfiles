----------------------------------------------------------------------------------
-- @file packer-config/init.lua
-- @author Hershel Shah
-- @brief Load Packer Modules
----------------------------------------------------------------------------------
-- Return Packer Setup
return require('packer').startup(function()
    -- Packer Pacakge Manager
    use 'wbthomason/packer.nvim'

    -- Dashboard
    use 'glepnir/dashboard-nvim'

    -- Colorschemes
    use 'Mofiqul/dracula.nvim'

    -- LSP Plugins
    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    }

    -- Mason
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup()
        end
    }
    use 'neovim/nvim-lspconfig'                    -- Configurations for Nvim LSP
    use 'hrsh7th/nvim-cmp'                         -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'                     -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-buffer'                       -- Buffer source for nvim-cmp
    use 'hrsh7th/cmp-path'                         -- Path source for nvim-cmp
    use 'hrsh7th/cmp-cmdline'                      -- CMD line source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require('lsp_signature').setup({})
        end
    }
    use 'onsails/lspkind.nvim'                     -- Adds Pictograms to LSP

    -- Diagnostic Display
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })

    -- Notify
    use {
        'rcarriga/nvim-notify',
        config = function ()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                timeout = 3000,
            }
            vim.notify = require('notify')
        end
    }

    -- Tree Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    -- Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Buffer Manager
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- Tree Sitter Syntax
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- Neovim Session Management System
    use {
        "olimorris/persisted.nvim",
        config = function()
            require("persisted").setup()
        end,
    }

    -- Comment Plugin
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Code Dimmer
    use {
        'folke/twilight.nvim',
        config = function()
            require("twilight").setup({})
        end
    }

    -- Display Colors
    -- use {
    --     'nnorcalli/nvim-colorizer.lua',
    --     config = function()
    --         require('colorizer').setup()
    --     end
    -- }

    -- Vim Surround
    use 'tpope/vim-surround'

    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                enable_check_bracket_line = false
            })
        end
    }

    -- Remote Work
    use {
        'chipsenkbeil/distant.nvim',
        config = function()
            require('distant').setup {
                -- Applies Chip's personal settings to every machine you connect to
                --
                -- 1. Ensures that distant servers terminate with no connections
                -- 2. Provides navigation bindings for remote directories
                -- 3. Provides keybinding to jump into a remote file's parent directory
                ['*'] = require('distant.settings').chip_default()
            }
        end
    }
end)
