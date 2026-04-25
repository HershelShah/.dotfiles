return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		{ "zapling/mason-conform.nvim", opts = {} },
	},
	keys = {
		{
			"<leader>lf",
			function() require("conform").format({ timeout_ms = 3000, lsp_format = "fallback" }) end,
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			cuda = { "clang-format" },
		},
		format_on_save = {
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
	},
}
