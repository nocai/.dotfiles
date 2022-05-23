-- vim.lsp.set_log_level("debug")

local settings = require("configs.lsp_settings")
local lsp = {}

function lsp.nvim_lspconfig()
	local lspconfig = require("lspconfig")

	local servers = { "pyright", "rust_analyzer", "tsserver", "denols" }
	for _, server in ipairs(servers) do
		local config = settings.config()
		lspconfig[server].setup(config)
	end

	local items = vim.fn.globpath(nvim.home .. "/lua/configs/lsp", "*.lua", false, true)
	for _, item in ipairs(items) do
		local server = vim.fn.fnamemodify(item, ":t:r")
		local config = require("configs.lsp." .. server)
		config = settings.config(config)
		lspconfig[server].setup(config)
	end
end

function lsp.null_ls()
	local ls = require("null-ls")
	ls.setup({
		sources = {
			ls.builtins.formatting.stylua,
		},
	})
end

function lsp.lsp_signature()
	require("lsp_signature").setup({
		bind = true,
		floating_window = true,
		hint_enable = false,
		floating_window_above_cur_line = true,
		timer_interval = 1000,
		handler_opts = {
			border = "rounded", -- double, single, shadow, none
		},
	})
end

function lsp.symbols_outline()
	-- init.lua
	vim.g.symbols_outline = {
		auto_preview = false,
		auto_close = false,
		width = 20,
		preview_bg_highlight = "Normal",
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = { "<CR>", "<2-LeftMouse>" },
			focus_location = "o",
			hover_symbol = { "<C-e>", "E" },
			toggle_preview = "<Tab>",
			rename_symbol = { "gn", "r", "rn", "rs" },
			code_actions = { "ga", "ca" },
		},
	}
	vim.keymap.set("n", "gO", "<cmd>SymbolsOutline<cr>")
	vim.cmd("hi link FocusedSymbol PmenuSel")
end

return lsp
