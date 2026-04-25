-- Keymaps
-- Leader is <Space> (set in config/lazy.lua)
-- Plugin-specific keymaps live in their plugin files:
--   lsp.lua:        gd, gR, gi, gt, gD, <leader>D, <leader>rs
--   fzf-lua.lua:    <leader>ff, <leader>fg, <leader>fb, <leader>fh, <leader>gb, <leader>gc
--   agentic:        <C-\>, <leader>aa toggle chat; <leader>an new session
--   treesitter:     <C-space>/<bs> select, [f/]f [m/]m [c/]c [i/]i [l/]l motions,
--                   a=/i= a/ia am/im ac/ic af/if al/il text objects,
--                   <leader>na/nm swap next, <leader>pa/pm swap prev
--   mini.surround:  sa (add), sd (delete), sr (replace)
--   mini.move:      <M-hjkl> move lines/selections
--   mini.splitjoin:  gS toggle single/multi-line

local map = vim.keymap.set

-- General
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })

-- Buffers (mini.bufremove provides Bdelete/Bwipeout)
map("n", "<leader>x", "<cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete buffer" })

-- File explorer (mini.files)
map("n", "<leader>e", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", { desc = "File explorer (current file)" })
map("n", "<leader>E", "<cmd>lua MiniFiles.open()<CR>", { desc = "File explorer (cwd)" })

-- Mini.map
map("n", "<leader>mm", "<cmd>lua MiniMap.toggle()<CR>", { desc = "Toggle minimap" })

-- Mini.trailspace
map("n", "<leader>tw", "<cmd>lua MiniTrailspace.trim()<CR>", { desc = "Trim trailing whitespace" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Window navigation (previously mini.basics)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Save with Ctrl-S (previously mini.basics)
map({ "n", "i", "x" }, "<C-s>", "<cmd>w<CR>", { desc = "Save" })
