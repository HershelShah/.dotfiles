-- todo-comments.nvim — highlight + search TODO/FIXME/HACK/NOTE (replaces mini.hipatterns)
return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	opts = { signs = false },
	keys = {
		{ "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "Find TODOs" },
	},
}
