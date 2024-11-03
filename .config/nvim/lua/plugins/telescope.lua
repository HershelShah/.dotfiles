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
		{ "<leader>z", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "File fuzzy find" },
		{ "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Show diagnostics" },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
		{ "<leader>w", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
		{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>c", "<cmd>Telescope resume<cr>", desc = "Resume search" },
		{ "<leader>s", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	},
	dependencies = { "nvim-lua/plenary.nvim" },
}
