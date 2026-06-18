-- multicursor.nvim — multiple cursors with full normal/insert/visual parity
-- Uses <leader>c (cursors) group; <leader>n is taken by treesitter swap.
return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	event = "VeryLazy",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()
		local set = vim.keymap.set

		-- Add cursors above/below the main cursor.
		set({ "n", "x" }, "<C-Up>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor up" })
		set({ "n", "x" }, "<C-Down>", function() mc.lineAddCursor(1) end, { desc = "Add cursor down" })

		-- Add/skip cursors by match of the word under cursor (or visual selection).
		set({ "n", "x" }, "<leader>cn", function() mc.matchAddCursor(1) end, { desc = "Add cursor at next match" })
		set({ "n", "x" }, "<leader>cN", function() mc.matchAddCursor(-1) end, { desc = "Add cursor at prev match" })
		set({ "n", "x" }, "<leader>cs", function() mc.matchSkipCursor(1) end, { desc = "Skip next match" })
		set({ "n", "x" }, "<leader>cA", function() mc.matchAllAddCursors() end, { desc = "Add cursors to all matches" })

		-- Keymaps active only while multiple cursors exist.
		mc.addKeymapLayer(function(layer)
			layer({ "n", "x" }, "<left>", mc.prevCursor)
			layer({ "n", "x" }, "<right>", mc.nextCursor)
			layer("n", "<leader>cx", mc.deleteCursor, { desc = "Delete cursor" })
			layer("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)
	end,
}
