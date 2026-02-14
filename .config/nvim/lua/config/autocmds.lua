-- Autocommands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Colorcolumn for code files
autocmd("Filetype", {
	group = augroup("ColorColumn", { clear = true }),
	pattern = { "python", "lua", "c", "cpp", "cuda" },
	command = "set colorcolumn=80",
})

-- Wrapping and spellcheck for prose
autocmd("Filetype", {
	group = augroup("Prose", { clear = true }),
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Auto-resize splits when terminal is resized
autocmd("VimResized", {
	group = augroup("AutoResize", { clear = true }),
	command = "tabdo wincmd =",
})

-- Close certain filetypes with q
autocmd("FileType", {
	group = augroup("CloseWithQ", { clear = true }),
	pattern = { "help", "man", "qf", "checkhealth", "lspinfo", "lazy", "mason" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})
