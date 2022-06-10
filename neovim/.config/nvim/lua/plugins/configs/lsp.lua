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
