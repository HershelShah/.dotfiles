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
               { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
               { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
               { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
               { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume search" },
               { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
               { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer fuzzy find" },
               { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
               { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
               { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
       },
       dependencies = { "nvim-lua/plenary.nvim" },
}
