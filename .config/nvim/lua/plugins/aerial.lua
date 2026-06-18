-- aerial.nvim — code outline / symbol sidebar (treesitter + LSP backends)
return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown", "man" },
	},
	keys = {
		{ "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Outline (aerial)" },
	},
}
