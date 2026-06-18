-- nvim-treesitter-context — sticky header showing the enclosing
-- function/class/loop while scrolling deep files (uses core treesitter).
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "VeryLazy",
	opts = {
		max_lines = 3, -- cap the sticky header height
		multiline_threshold = 1, -- collapse multi-line signatures to one line
	},
	keys = {
		{ "<leader>tc", function() require("treesitter-context").toggle() end, desc = "Toggle sticky context" },
	},
}
