local lsp = require("lsp-zero")
local builtin = require('telescope.builtin')

lsp.preset("recommended")

lsp.ensure_installed({
    'clangd',
    'jedi_language_server',
    'lua_ls',
    -- 'pylint',
})

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

-- local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--   ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--   ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--   ["<C-Space>"] = cmp.mapping.complete(),
-- })
--
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil
--
-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings
-- })

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>dv", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>]", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>[", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<leader>llr', builtin.lsp_references, {})
    vim.keymap.set('n', '<leader>lic', builtin.lsp_incoming_calls, {})
    vim.keymap.set('n', '<leader>loc', builtin.lsp_outgoing_calls, {})
    vim.keymap.set('n', '<leader>lds', builtin.lsp_document_symbols, {})
    -- vim.keymap.set('n', '<leader>lws', builtin.lsp_workplace_symbols, {})
    -- vim.keymap.set('n', '<leader>ldws', builtin.lsp_dynamic_workplace_symbols, {})
    vim.keymap.set('n', '<leader>d', builtin.diagnostics, {})
    vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, {})
    vim.keymap.set('n', '<leader>ltd', builtin.lsp_type_definitions, {})
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set('v', '<leader>f', vim.lsp.buf.format, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
