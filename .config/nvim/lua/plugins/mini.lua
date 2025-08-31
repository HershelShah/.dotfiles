return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.bracketed").setup()
		require("mini.bufremove").setup()
		require("mini.comment").setup()
		require("mini.completion").setup()
		require("mini.cursorword").setup()
		require("mini.extra").setup()
		require("mini.files").setup()
		require("mini.indentscope").setup()
		require("mini.map").setup()
		require("mini.move").setup()
		require("mini.pairs").setup()
		require("mini.pick").setup()
		require("mini.splitjoin").setup()
		require("mini.starter").setup()
		require("mini.statusline").setup()
		require("mini.surround").setup()
		require("mini.tabline").setup()
		require("mini.trailspace").setup()
		require("mini.visits").setup()
		require("mini.basics").setup( -- No need to copy this inside `setup()`. Will be used automatically.
			{
				-- Options. Set to `false` to disable.
				options = {
					-- Basic options ('number', 'ignorecase', and many more)
					basic = true,

					-- Extra UI features ('winblend', 'cmdheight=0', ...)
					extra_ui = false,

					-- Presets for window borders ('single', 'double', ...)
					win_borders = "default",
				},

				-- Mappings. Set to `false` to disable.
				mappings = {
					-- Basic mappings (better 'jk', save with Ctrl+S, ...)
					basic = true,

					-- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
					-- Supply empty string to not create these mappings.
					option_toggle_prefix = [[\]],

					-- Window navigation with <C-hjkl>, resize with <C-arrow>
					windows = true,

					-- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
					move_with_alt = false,
				},

				-- Autocommands. Set to `false` to disable
				autocommands = {
					-- Basic autocommands (highlight on yank, start Insert in terminal, ...)
					basic = true,

					-- Set 'relativenumber' only in linewise and blockwise Visual mode
					relnum_in_visual_mode = true,
				},

				-- Whether to disable showing non-error feedback
				silent = false,
			}
		)
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
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
