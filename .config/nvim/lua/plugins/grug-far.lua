-- grug-far.nvim — project-wide find & replace (ripgrep; ast-grep for structural)
return {
	"MagicDuck/grug-far.nvim",
	opts = {},
	keys = {
		{ "<leader>sr", function() require("grug-far").open() end, desc = "Search/replace (project)" },
		{
			"<leader>sw",
			function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
			desc = "Search/replace word under cursor",
		},
	},
}
