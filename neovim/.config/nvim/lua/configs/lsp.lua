-- vim.lsp.set_log_level("debug")

local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", nvim.diagnostics.icons.error)
lspSymbol("Info", nvim.diagnostics.icons.info)
lspSymbol("Hint", nvim.diagnostics.icons.hint)
lspSymbol("Warn", nvim.diagnostics.icons.warning)

vim.diagnostic.config({
	-- virtual_text = {
	-- 	prefix = "",
	-- 	spacing = 0,
	-- },
	-- signs = true,
	update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = nvim.window.border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})

-- suppress error messages from lang servers
-- vim.notify = function(msg, log_level)
-- 	if msg:match("exit code") then
-- 		return
-- 	end
-- 	if log_level == vim.log.levels.ERROR then
-- 		vim.api.nvim_err_writeln(msg)
-- 	else
-- 		vim.api.nvim_echo({ { msg } }, true, {})
-- 	end
-- end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { buffer = bufnr }
	-- mapping: K => E
	vim.keymap.set("n", "E", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.keymap.set({ "n", "i" }, "<C-e>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.keymap.set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

	vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

	vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.keymap.set({ "v" }, "ga", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
	-- mapping by telescope
	-- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)

	if client.resolved_capabilities.code_lens then
		-- vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
		vim.cmd([[autocmd BufEnter,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
		vim.keymap.set("n", "gl", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
	end

	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
			augroup lsp_document_highlight
				autocmd!
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]])
	end

	-- formatting
	vim.keymap.set("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	-- format on save
	-- if client.resolved_capabilities.document_formatting then
	-- 	vim.api.nvim_command([[augroup Format]])
	-- 	vim.api.nvim_command([[autocmd! * <buffer>]])
	-- 	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
	-- 	vim.api.nvim_command([[augroup END]])
	-- end
end

local function setting(config)
	config = config or {}

	config.on_attach = on_attach
	config.capabilities = capabilities
	config.flags = {
		debounce_text_changes = 150,
	}
	return config
end

local lspconfig = require("lspconfig")

local servers = { "pyright", "rust_analyzer", "tsserver", "denols" }
for _, server in ipairs(servers) do
	lspconfig[server].setup(setting())
end

local items = vim.fn.globpath(nvim.home .. "/lua/configs/lsp", "*.lua", false, true)
for _, item in ipairs(items) do
	local server = vim.fn.fnamemodify(item, ":t:r")
	local config = require("configs.lsp." .. server)
	lspconfig[server].setup(setting(config))
end

local lsp = {
	setting = setting,
}

function lsp.nvim_lsp_installer()
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
			rename_symbol = { "gn", "r" },
			code_actions = { "ga", "ca" },
		},
	}
	vim.keymap.set("n", "gO", "<cmd>SymbolsOutline<cr>")
	vim.cmd("hi link FocusedSymbol PmenuSel")

	-- auto close symbols-outline window when it is the last window
	nvim.set_symbols_outline_state = function()
		vim.g["symbols_outline_state"] = require("symbols-outline").state
	end

	vim.cmd([[
		autocmd BufEnter * :lua nvim.set_symbols_outline_state()
		autocmd BufEnter * if winnr('$') == 1 && exists('g:symbols_outline_state.outline_buf') && g:symbols_outline_state.outline_buf | quit | endif
	]])
end

return lsp
