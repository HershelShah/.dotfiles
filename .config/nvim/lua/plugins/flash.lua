-- flash.nvim — label-based jump navigation + treesitter node selection
-- `s` is free (nvim-surround uses the ys/ds/cs grammar). `<C-space>` runs flash
-- treesitter — restoring the incremental selection removed in the
-- nvim-treesitter main-branch rewrite, and avoiding nvim-surround's visual `S`.
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "<C-space>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	},
}
