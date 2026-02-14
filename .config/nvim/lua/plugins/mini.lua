-- mini.nvim — collection of small independent modules
-- Modules removed in revamp:
--   mini.comment    → built-in gc/gcc in nvim 0.10+
--   mini.completion → replaced by blink.cmp
--   mini.pick       → replaced by fzf-lua
--   mini.extra      → was a companion to mini.pick
--   mini.visits     → was a companion to mini.pick
--   mini.basics     → options/mappings/autocmds redundant with nvim 0.11 defaults + keymaps.lua
--   mini.bracketed  → [b/]b, [d/]d, [q/]q built-in since nvim 0.11
return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.bufremove").setup() -- :Bdelete without closing window
		require("mini.cursorword").setup() -- underline word under cursor
		require("mini.indentscope").setup() -- animated indent guide
		require("mini.map").setup() -- minimap sidebar
		require("mini.move").setup() -- <M-hjkl> move lines/selections
		require("mini.pairs").setup() -- auto-close brackets/quotes
		require("mini.splitjoin").setup() -- gS toggle single/multi-line
		require("mini.starter").setup() -- start screen
		require("mini.statusline").setup() -- statusline
		require("mini.surround").setup() -- sa/sd/sr surround editing
		require("mini.tabline").setup() -- buffer tabline
		require("mini.trailspace").setup() -- highlight/trim trailing whitespace

		-- mini.hipatterns — highlight TODO/FIXME/HACK/NOTE and hex colors
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- mini.clue — keybinding hints (like which-key)
		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },
				{ mode = "i", keys = "<C-x>" },
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },
				{ mode = "n", keys = "<C-w>" },
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
				{ mode = "n", keys = "[" },
				{ mode = "n", keys = "]" },
				{ mode = "x", keys = "[" },
				{ mode = "x", keys = "]" },
			},
			clues = {
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
		})
	end,
}
