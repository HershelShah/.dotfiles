-- Tiny popup showing LSP progress (clangd indexing, mason install, etc.)
return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {},
}
