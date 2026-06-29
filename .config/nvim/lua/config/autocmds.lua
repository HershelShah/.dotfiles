-- Autocommands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Colorcolumn for code files
autocmd("Filetype", {
	group = augroup("ColorColumn", { clear = true }),
	pattern = { "python", "lua", "c", "cpp", "cuda" },
	command = "set colorcolumn=80",
})

-- 2-space indent for web/data filetypes (overrides global 4 from options.lua)
autocmd("FileType", {
	group = augroup("TwoSpaceIndent", { clear = true }),
	pattern = { "lua", "javascript", "typescript", "html", "css", "json", "yaml", "toml", "markdown" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
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
		vim.hl.on_yank({ timeout = 200 })
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

-- Reload files changed on disk (e.g. Claude's auto-accepted edits) so the buffer
-- and gitsigns reflect them without a manual :e. autoread only reloads on its own
-- triggers, so nudge it with :checktime. TermLeave fires when you <C-hjkl> out of
-- the Claude pane, refreshing whatever it just edited.
vim.o.autoread = true
autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermLeave" }, {
	group = augroup("AutoReadCheck", { clear = true }),
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})
