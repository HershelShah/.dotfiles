return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({})
		fzf.register_ui_select()
	end,
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Help tags" },
		{ "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
	},
}
