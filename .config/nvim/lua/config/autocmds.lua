local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Set colorcolumn
autocmd("Filetype", {
	pattern = { "python", "lua", "c", "cpp", "cuda" },
	command = "set colorcolumn=80",
})

autocmd("Filetype", {
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
