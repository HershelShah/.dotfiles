-- harpoon (harpoon2) — pin a handful of hot files and jump between them
-- <leader>ja add, <leader>jj menu, <leader>1-4 jump.
return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		local map = vim.keymap.set

		map("n", "<leader>ja", function() harpoon:list():add() end, { desc = "Harpoon add file" })
		map("n", "<leader>jj", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
		for i = 1, 4 do
			map("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon to file " .. i })
		end
	end,
}
