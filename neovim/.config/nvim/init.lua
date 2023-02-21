_G.ivim = {
	lsp_keys = {
		Explorer = "<leader><space>",
		GotoDefinition = "gd",
		PeekDefinition = "gD",
		GotoTypeDefinition = "gy",
		PeekTypeDefinition = "gY",
		GotoImplementation = "gI",
		PeekImplementation = "<leader>gI",
		GotoReferences = "<leader>gr",
		GotoSymbols = "<leader>gs",
		CodeActions = "<leader>ca",
		FormatDocument = "<leader>cf",
		Rename = "<leader>cr",
		DiagnosticPrev = "[d",
		DiagnosticNext = "]d",
	},
	is_vscode = vim.g.vscode == 1,
	git_proxy_prefix = "https://ghproxy.com/",
}
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
