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
            'gbrlsnchs/telescope-lsp-handlers.nvim',
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

    -- Tree Sitter Context for Viewing Long Functions
    use {
        'nvim-treesitter/nvim-treesitter-context',
        requires = { 'nvim-treesitter/nvim-treesitter' },
    }

    -- Comment Plugin
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('comment').setup({})
        end
    }

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
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- Autopairs
    use { 'windwp/nvim-autopairs' }

    -- Git Signs
    use { 'lewis6991/gitsigns.nvim' }

    use({
        "kylechui/nvim-surround",
        tag = "*",
    })

    -- Neovim Session Management System
    use({
        'olimorris/persisted.nvim',
        config = function()
            require('persisted').setup({
                autoload = false,
                on_autoload_no_session = function()
                    vim.notify("No existing session to load.")
                end,
                command = "VimLeavePre",
                use_git_branch = true,
            })
        end,
    })

    use {
        'echasnovski/mini.nvim',
        branch = 'stable',
        config = function()
            require('mini.map').setup()
        end
    }

    -- LSP Plugins
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- Adds Pictograms to LSP
            { 'onsails/lspkind.nvim' },
            { 'ray-x/lsp_signature.nvim' },
        }
    }

    use {
        'phaazon/mind.nvim',
        branch = 'v2.2',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('mind').setup({})
        end
    }

    -- Document Generation
    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup({ snippet_engine = "luasnip" })
        end,
        requires = { 'nvim-treesitter/nvim-treesitter' },
        tag = "*"
    }

end)
