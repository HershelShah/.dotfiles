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
                timeout = 5000,
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
end)
