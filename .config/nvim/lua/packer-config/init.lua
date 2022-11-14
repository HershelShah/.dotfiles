----------------------------------------------------------------------------------
-- @file packer-config/init.lua
-- @author Hershel Shah
-- @brief Load Packer Modules
----------------------------------------------------------------------------------
-- Return Packer Setup
return require('packer').startup(function()
    -- Packer Pacakge Manager
    use 'wbthomason/packer.nvim'

    -- Colorschemes
    use 'Mofiqul/dracula.nvim'

    -- Notify
    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                timeout = 3000,
            }
            vim.notify = require('notify')
        end
    }

    -- Comment Plugin
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Tree Sitter Syntax
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Tree Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    -- Buffer Manager
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Dashboard
    use 'glepnir/dashboard-nvim'

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

    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({})
        end
    }

    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

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

    -- Configurations for Nvim LSP
    use 'neovim/nvim-lspconfig'

    -- Autocompletion plugin
    use 'hrsh7th/nvim-cmp'

    -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'

    -- Buffer source for nvim-cmp
    use 'hrsh7th/cmp-buffer'

    -- Path source for nvim-cmp
    use 'hrsh7th/cmp-path'

    -- CMD line source for nvim-cmp
    use 'hrsh7th/cmp-cmdline'

    -- LUA Snips Autocomplete
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    -- LSP Signature
    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require('lsp_signature').setup({})
        end
    }
    -- Adds Pictograms to LSP
    use 'onsails/lspkind.nvim'

    -- Preview Window
    use {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {}
        end
    }
end)
