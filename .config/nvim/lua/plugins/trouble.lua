-- Diagnostics / symbols / quickfix grouped by file with previews
return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {},
	keys = {
		{ "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble diagnostics" },
		{ "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble symbols outline" },
	},
}
