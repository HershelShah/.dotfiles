-- clangd-specific features: switch source/header, AST view, type hierarchy
return {
	"p00f/clangd_extensions.nvim",
	ft = { "c", "cpp", "cuda" },
	opts = {
		inlay_hints = { inline = false }, -- using vim.lsp.inlay_hint API instead
		ast = { role_icons = {}, kind_icons = {} },
	},
}
