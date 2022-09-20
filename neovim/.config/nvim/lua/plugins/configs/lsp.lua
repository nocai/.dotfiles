local M = {}

function M.lsp()
	local setting = require("core.lsp_setting")
	local lspconfig = require("lspconfig")

	local servers = { "pyright", "tsserver", "denols" }
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

function M.mason()
	require("mason").setup({
		ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim
		ui = { border = "rounded" },
		github = {
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

			-- ls.builtins.diagnostics.golangci_lint,
			-- ls.builtins.diagnostics.markdownlint,
			-- ls.builtins.diagnostics.yamllint,
		},
	})
end

return M
