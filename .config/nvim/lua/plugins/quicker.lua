-- quicker.nvim — editable, prettier quickfix list (edit results + :w to apply)
return {
	"stevearc/quicker.nvim",
	ft = "qf",
	opts = {},
	keys = {
		{ "<leader>tq", function() require("quicker").toggle() end, desc = "Toggle quickfix" },
	},
}
