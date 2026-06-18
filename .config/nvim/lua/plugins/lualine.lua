-- lualine.nvim — statusline (replaces mini.statusline)
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			theme = "tokyonight",
			globalstatus = true, -- single statusline (laststatus=3)
			section_separators = "",
			component_separators = "|",
		},
	},
}
