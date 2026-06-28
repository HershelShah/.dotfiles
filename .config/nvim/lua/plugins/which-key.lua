-- which-key.nvim — leader keybinding hints (replaces the old mini.clue popup)
-- Auto-discovers every mapping from its `desc`; the spec below only labels the
-- <Leader> prefix groups. Deferred to VeryLazy so plugin keymaps register first.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>a", group = "claude" },
			{ "<leader>c", group = "multicursor" },
			{ "<leader>d", group = "diagnostics" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>h", group = "hunk" },
			{ "<leader>j", group = "harpoon" },
			{ "<leader>l", group = "symbols" },
			{ "<leader>n", group = "swap next" },
			{ "<leader>p", group = "swap prev" },
			{ "<leader>r", group = "restart" },
			{ "<leader>s", group = "search/replace" },
			{ "<leader>t", group = "toggle" },
			-- Built-in LSP prefix (nvim 0.11 defaults: grn/gra/grr/gri/grt)
			{ "gr", group = "lsp" },
		},
	},
	keys = {
		{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps (which-key)" },
	},
}
