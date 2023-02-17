vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	silent = true,
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	silent = true,
	border = "rounded",
})

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jsonls = false,
			},
			diagnostics = {
				float = {
					focusable = false,
					border = "rounded"
				},
			}
		}
	},
}
