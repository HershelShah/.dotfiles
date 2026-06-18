-- oil.nvim — edit the filesystem like a normal buffer (replaces mini.files + netrw)
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false, -- load eagerly so it can hijack netrw / open directories
	opts = {
		default_file_explorer = true,
		view_options = { show_hidden = true },
	},
	keys = {
		{ "<leader>e", "<cmd>Oil<cr>", desc = "File explorer (current dir)" },
		{ "<leader>E", "<cmd>Oil .<cr>", desc = "File explorer (cwd)" },
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
	},
}
