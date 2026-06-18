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
			automatic_enable = false,
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
				map("n", "gD", "<cmd>FzfLua lsp_declarations<CR>", "Go to declaration")
				map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- clangd-specific: switch between source/header
				if client and client.name == "clangd" then
					map("n", "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", "Switch source/header")
				end

				-- Inlay hints: enable on attach if supported, toggle with <leader>th
				if client and client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					map("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
							{ bufnr = event.buf }
						)
					end, "Toggle inlay hints")
				end

				-- Highlight other references to the symbol under cursor (replaces mini.cursorword)
				if client and client:supports_method("textDocument/documentHighlight") then
					local hl = vim.api.nvim_create_augroup("UserDocHighlight" .. event.buf, { clear = true })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = hl,
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = hl,
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Built-in since nvim 0.10+: K (hover), grn (rename), <C-W>d (diagnostic float)
			end,
		})

		-- Diagnostic UI (nvim 0.11+ API)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			severity_sort = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				prefix = "●",
				source = "if_many", -- show source only when multiple LSPs report
			},
			float = { border = "rounded", source = true },
		})

		-- Capabilities from blink.cmp (shared across all servers)
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Resolve the Python interpreter for a project: prefer an already-active
		-- environment, otherwise a uv/local .venv at the project root. Returns nil
		-- to let pyright fall back to the system python.
		local function venv_python(root)
			if vim.env.VIRTUAL_ENV then
				return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
			end
			if root then
				local py = vim.fs.joinpath(root, ".venv", "bin", "python")
				if vim.uv.fs_stat(py) then
					return py
				end
			end
			return nil
		end

		-- Server configs using vim.lsp.config (nvim 0.11+)
		vim.lsp.config("clangd", {
			capabilities = capabilities,
		})

		vim.lsp.config("pyright", {
			capabilities = capabilities,
			-- Point pyright at the project's uv/.venv interpreter (if any) so it
			-- resolves installed packages instead of the global site-packages.
			before_init = function(_, config)
				local py = venv_python(config.root_dir)
				if py then
					config.settings.python = config.settings.python or {}
					config.settings.python.pythonPath = py
				end
			end,
			settings = {
				python = {
					analysis = {
						inlayHints = {
							variableTypes = true,
							functionReturnTypes = true,
						},
					},
				},
			},
		})

		vim.lsp.config("cmake", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					hint = { enable = true },
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
		vim.lsp.enable({ "clangd", "cmake", "pyright", "lua_ls" })
	end,
}
