return {
	"nvim-telescope/telescope.nvim",
	tag = '0.1.8',
	event = "VeryLazy",
	opts = {
		pickers = {
			git_branches = { show_remote_tracking_branches = false },
		},
	},
       keys = {
               { "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
               { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
               { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
       },
       dependencies = { "nvim-lua/plenary.nvim" },
}
