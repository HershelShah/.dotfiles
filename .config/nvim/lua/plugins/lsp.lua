return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"cmake",
				"lua_ls",
				"pyright",
			},
			automatic_installation = true,
		})

		-- LSP keymaps (set on attach via LspAttach autocmd)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
			callback = function(event)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
				end

				-- FzfLua pickers (override built-ins to avoid quickfix/native select UI)
				map("n", "gra", "<cmd>FzfLua lsp_code_actions<CR>", "Code actions")
				map("n", "gR", "<cmd>FzfLua lsp_references<CR>", "Show LSP references")
				map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", "Show LSP definitions")
				map("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", "Show LSP implementations")
				map("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", "Show LSP type definitions")
				map("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", "Document symbols")
				map("n", "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<CR>", "Workspace symbols")
				map("n", "<leader>D", "<cmd>FzfLua diagnostics_document<CR>", "Buffer diagnostics")
				map("n", "<leader>dw", "<cmd>FzfLua diagnostics_workspace<CR>", "Workspace diagnostics")

				-- Non-redundant mappings
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")

				-- Built-in since nvim 0.10+: K (hover), grn (rename), <C-W>d (diagnostic float)
			end,
		})

		-- Diagnostic signs (nvim 0.11+ API, replaces deprecated vim.fn.sign_define)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- Capabilities from blink.cmp (shared across all servers)
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Server configs using vim.lsp.config (nvim 0.11+)
		vim.lsp.config("clangd", {
			capabilities = capabilities,
		})

		vim.lsp.config("pyright", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- Enable configured servers
		vim.lsp.enable({ "clangd", "pyright", "lua_ls" })
	end,
}
