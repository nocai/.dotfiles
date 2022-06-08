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
	update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = nvim.window.border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = nvim.window.border,
})

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

	-- formatting
	vim.keymap.set("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	-- format on save
	-- if client.resolved_capabilities.document_formatting then
	-- 	vim.api.nvim_command([[augroup Format]])
	-- 	vim.api.nvim_command([[autocmd! * <buffer>]])
	-- 	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
	-- 	vim.api.nvim_command([[augroup END]])
	-- end

	if client.resolved_capabilities.code_lens then
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
end

local M = {
	config = function(cfg)
		cfg = cfg or {}

		cfg.on_attach = on_attach
		cfg.capabilities = capabilities
		cfg.flags = {
			debounce_text_changes = 150,
		}
		return cfg
	end,
}

local lspconfig = require("lspconfig")

local servers = { "pyright", "rust_analyzer", "tsserver", "denols" }
for _, server in ipairs(servers) do
	local cfg = M.config()
	lspconfig[server].setup(cfg)
end

local items = vim.fn.globpath(nvim.home .. "/lua/configs/lsp", "*.lua", false, true)
for _, item in ipairs(items) do
	local server = vim.fn.fnamemodify(item, ":t:r")
	local cfg = require("configs.lsp." .. server)
	lspconfig[server].setup(M.config(cfg))
end

return M
