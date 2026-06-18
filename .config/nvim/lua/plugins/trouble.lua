-- Diagnostics / symbols / quickfix grouped by file with previews
return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {},
	keys = {
		{ "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble diagnostics" },
		-- symbols outline handled by aerial (<leader>o) and fzf-lua (<leader>ls)
	},
}
