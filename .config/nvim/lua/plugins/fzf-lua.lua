return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({})
		-- Route every vim.ui.select() menu (LSP code actions, Claude model
		-- picker, any plugin's selection) through fzf-lua, sized to the content.
		fzf.register_ui_select(function(_, items)
			local h = (#items + 4) / vim.o.lines
			h = math.max(0.15, math.min(0.70, h))
			return { winopts = { height = h, width = 0.55, row = 0.45, col = 0.5 } }
		end)
	end,
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Help tags" },
		{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
		{ "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
	},
}
