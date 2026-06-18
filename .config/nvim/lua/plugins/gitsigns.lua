return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Navigation
			map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
			map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")

			-- Actions
			map("n", "<leader>hs", gs.stage_hunk, "Stage/unstage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage/unstage hunk")
			map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
			map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
			map("n", "<leader>hd", gs.diffthis, "Diff this")
			map("n", "<leader>td", gs.toggle_deleted, "Toggle deleted")
		end,
	},
}
