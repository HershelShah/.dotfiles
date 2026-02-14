return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	build = "make",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"ibhagwan/fzf-lua",
		"zbirenbaum/copilot.lua",
	},
	opts = {
		provider = "copilot",
	},
}
