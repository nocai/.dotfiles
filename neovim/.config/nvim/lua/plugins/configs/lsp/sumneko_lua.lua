-- sumneko_lua
return {
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			diagnostics = { enable = true, globals = { "vim", "redis", "nvim", "jit" } },
			workspace = {
				-- library = vim.api.nvim_get_runtime_file("", true),

				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	},
}
