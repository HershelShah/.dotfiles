--------------------------------------------------------------------------------
-- @file lsp-config/nvim-cmp.lua
-- @author Hershel Shah
-- @brief Completion Engine Settings
--------------------------------------------------------------------------------

-- nvim-cmp Setup
local cmp_status_ok, cmp = pcall(require, 'cmp')
local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
local lspkind_status_ok, lspkind = pcall(require, 'lspkind')

if not cmp_status_ok then
    vim.notify("Couldn't load cmp" .. cmp, "error")
    return
end

if not luasnip_status_ok then
    vim.notify("Couldn't load luasnip" .. luasnip, "error")
    return
end

if not lspkind_status_ok then
    vim.notify("Couldn't load lspkind" .. lspkind, "error")
    return
end

Location = {
    buffer = "◉ Buffer",
    nvim_lsp = "👐 LSP",
    nvim_lua = "🌙 Lua",
    path = "🚧 Path",
    luasnip = "🌜 LuaSnip"
}

cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'orgmode' },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
                fallback()
            end
        end,
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.menu = Location[entry.source.name]
            return vim_item
        end
    },
}
