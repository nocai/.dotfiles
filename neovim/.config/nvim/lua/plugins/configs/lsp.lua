local M = {}

function M.lsp()
	local setting = require("core.lsp_setting")
	local lspconfig = require("lspconfig")

	local servers = { "pyright", "rust_analyzer", "tsserver", "denols" }
	for _, server in ipairs(servers) do
		local config = setting.config()
		lspconfig[server].setup(config)
	end

	local items = vim.fn.globpath(nvim.home .. "/lua/plugins/configs/lsp", "*.lua", false, true)
	for _, item in ipairs(items) do
		local server = vim.fn.fnamemodify(item, ":t:r")
		local config = require("plugins.configs.lsp." .. server)
		lspconfig[server].setup(setting.config(config))
	end
end

function M.nvim_lsp_installer()
	require("nvim-lsp-installer").setup({
		automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
		ui = {
			keymaps = {
				-- Keymap to install the server under the current cursor position
				install_server = "l",
			},
		},
		github = {
			-- The template URL to use when downloading assets from GitHub.
			-- The placeholders are the following (in order):
			-- 1. The repository (e.g. "rust-lang/rust-analyzer")
			-- 2. The release version (e.g. "v0.3.0")
			-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
			download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
		},
	})
end

function M.null_ls()
	local ls = require("null-ls")
	ls.setup({
		sources = {
			ls.builtins.formatting.stylua,
			-- ls.builtins.formatting.markdownlint,

			-- ls.builtins.code_actions.refactoring,
			-- ls.builtins.completion.luasnip,
			ls.builtins.completion.spell.with({
				filetypes = { "markdown" },
			}),

			ls.builtins.diagnostics.golangci_lint,
			-- ls.builtins.diagnostics.markdownlint,
			-- ls.builtins.diagnostics.yamllint,
		},
	})
end

return M
