return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- main-branch API; requires nvim 0.12+ (nightly)
	build = ":TSUpdate",
	lazy = false, -- FileType autocmd must be registered before the first buffer loads
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
	},
	config = function()
		local langs = require("config.ts_parsers")

		-- Install any parsers we don't already have (async, no-op when complete).
		local ts = require("nvim-treesitter")
		local installed = ts.get_installed("parsers")
		local missing = vim.tbl_filter(function(l)
			return not vim.tbl_contains(installed, l)
		end, langs)
		if #missing > 0 then
			ts.install(missing)
		end

		-- Enable highlighting (core) and treesitter indentation per filetype.
		-- Match on the parser language resolved from the filetype (so e.g.
		-- filetype "sh" -> parser "bash", "help" -> "vimdoc"), and pcall the
		-- start since the parser may still be installing on a fresh machine.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-features", { clear = true }),
			callback = function(ev)
				local ft = vim.bo[ev.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft) or ft
				if pcall(vim.treesitter.start, ev.buf, lang) then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		-- Textobjects (main branch): explicit setup + manual keymaps.
		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true },
			move = { set_jumps = true },
		})

		local select = require("nvim-treesitter-textobjects.select")
		local swap = require("nvim-treesitter-textobjects.swap")
		local move = require("nvim-treesitter-textobjects.move")

		-- Select: { lhs, query, desc }
		local selects = {
			{ "a=", "@assignment.outer", "Select outer part of an assignment" },
			{ "i=", "@assignment.inner", "Select inner part of an assignment" },
			{ "l=", "@assignment.lhs", "Select left hand side of an assignment" },
			{ "r=", "@assignment.rhs", "Select right hand side of an assignment" },
			{ "aa", "@parameter.outer", "Select outer part of a parameter/argument" },
			{ "ia", "@parameter.inner", "Select inner part of a parameter/argument" },
			{ "ai", "@conditional.outer", "Select outer part of a conditional" },
			{ "ii", "@conditional.inner", "Select inner part of a conditional" },
			{ "al", "@loop.outer", "Select outer part of a loop" },
			{ "il", "@loop.inner", "Select inner part of a loop" },
			{ "af", "@call.outer", "Select outer part of a function call" },
			{ "if", "@call.inner", "Select inner part of a function call" },
			{ "am", "@function.outer", "Select outer part of a method/function definition" },
			{ "im", "@function.inner", "Select inner part of a method/function definition" },
			{ "ac", "@class.outer", "Select outer part of a class" },
			{ "ic", "@class.inner", "Select inner part of a class" },
		}
		for _, m in ipairs(selects) do
			vim.keymap.set({ "x", "o" }, m[1], function()
				select.select_textobject(m[2], "textobjects")
			end, { desc = m[3] })
		end

		-- Swap: { lhs, query, fn, desc }
		local swaps = {
			{ "<leader>na", "@parameter.inner", swap.swap_next, "Swap next parameter/argument" },
			{ "<leader>nm", "@function.outer", swap.swap_next, "Swap next method/function" },
			{ "<leader>pa", "@parameter.inner", swap.swap_previous, "Swap previous parameter/argument" },
			{ "<leader>pm", "@function.outer", swap.swap_previous, "Swap previous method/function" },
		}
		for _, m in ipairs(swaps) do
			vim.keymap.set("n", m[1], function()
				m[3](m[2])
			end, { desc = m[4] })
		end

		-- Move: { lhs, query, fn, desc, query_group? }
		local moves = {
			{ "]f", "@call.outer", move.goto_next_start, "Next function call start" },
			{ "]m", "@function.outer", move.goto_next_start, "Next method/function def start" },
			{ "]c", "@class.outer", move.goto_next_start, "Next class start" },
			{ "]i", "@conditional.outer", move.goto_next_start, "Next conditional start" },
			{ "]l", "@loop.outer", move.goto_next_start, "Next loop start" },
			{ "]s", "@scope", move.goto_next_start, "Next scope", "locals" },
			{ "]z", "@fold", move.goto_next_start, "Next fold", "folds" },
			{ "]F", "@call.outer", move.goto_next_end, "Next function call end" },
			{ "]M", "@function.outer", move.goto_next_end, "Next method/function def end" },
			{ "]C", "@class.outer", move.goto_next_end, "Next class end" },
			{ "]I", "@conditional.outer", move.goto_next_end, "Next conditional end" },
			{ "]L", "@loop.outer", move.goto_next_end, "Next loop end" },
			{ "[f", "@call.outer", move.goto_previous_start, "Prev function call start" },
			{ "[m", "@function.outer", move.goto_previous_start, "Prev method/function def start" },
			{ "[c", "@class.outer", move.goto_previous_start, "Prev class start" },
			{ "[i", "@conditional.outer", move.goto_previous_start, "Prev conditional start" },
			{ "[l", "@loop.outer", move.goto_previous_start, "Prev loop start" },
			{ "[F", "@call.outer", move.goto_previous_end, "Prev function call end" },
			{ "[M", "@function.outer", move.goto_previous_end, "Prev method/function def end" },
			{ "[C", "@class.outer", move.goto_previous_end, "Prev class end" },
			{ "[I", "@conditional.outer", move.goto_previous_end, "Prev conditional end" },
			{ "[L", "@loop.outer", move.goto_previous_end, "Prev loop end" },
		}
		for _, m in ipairs(moves) do
			vim.keymap.set({ "n", "x", "o" }, m[1], function()
				m[3](m[2], m[5] or "textobjects")
			end, { desc = m[4] })
		end
	end,
}
