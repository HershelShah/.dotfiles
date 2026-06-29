-- Keymaps
-- Leader is <Space> (set in config/lazy.lua)
-- Plugin-specific keymaps live in their plugin files:
--   lsp.lua:        gd, gR, gi, gt, gD, <leader>D, <leader>rs
--   fzf-lua.lua:    <leader>ff, <leader>fg, <leader>fb, <leader>fh, <leader>fk (keymaps),
--                   <leader>ft (todos), <leader>gb, <leader>gc
--   claudecode:     <leader>ac toggle, af focus, ar resume, aC continue,
--                   am model, ab add buf, as send (v), aa accept diff, ad deny
--   treesitter:     [f/]f [m/]m [c/]c [i/]i [l/]l motions,
--                   a=/i= a/ia am/im ac/ic af/if al/il text objects,
--                   <leader>na/nm swap next, <leader>pa/pm swap prev
--   flash:          s jump, <C-space> treesitter select, r remote (operator)
--   multicursor:    <C-Up>/<C-Down> add cursor, <leader>c* (next/skip/all)
--   aerial:         <leader>o outline toggle
--   grug-far:       <leader>sr replace, <leader>sw replace word
--   harpoon:        <leader>ja add, <leader>jj menu, <leader>1-4 jump
--   quicker:        <leader>tq toggle editable quickfix
--   oil:            <leader>e / <leader>E / - file explorer
--   nvim-surround:  ys{motion}{char} add, ds delete, cs change, visual S
--   todo-comments:  <leader>ft find TODOs
--   stock:          <M-j>/<M-k> move line/selection (this file)

local map = vim.keymap.set

-- General
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })

-- Delete buffer without closing the window (replaces mini.bufremove)
map("n", "<leader>x", function()
	local cur = vim.api.nvim_get_current_buf()
	vim.cmd("bprevious")
	pcall(vim.cmd, "confirm bdelete " .. cur)
end, { desc = "Delete buffer" })

-- File explorer (<leader>e / <leader>E) is provided by oil.nvim

-- Trim trailing whitespace (replaces mini.trailspace)
map("n", "<leader>tw", function()
	local view = vim.fn.winsaveview()
	vim.cmd([[keeppatterns %s/\s\+$//e]])
	vim.fn.winrestview(view)
end, { desc = "Trim trailing whitespace" })

-- Move lines/selections up and down (replaces mini.move)
map("n", "<M-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("x", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("x", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Window navigation (previously mini.basics)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Same nav from terminal-mode, so <C-hjkl> escapes the Claude Code pane too
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Go to left window" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Go to lower window" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Go to upper window" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Go to right window" })

-- Save with Ctrl-S (previously mini.basics)
map({ "n", "i", "x" }, "<C-s>", "<cmd>w<CR>", { desc = "Save" })
