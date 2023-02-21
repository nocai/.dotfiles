-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.del("n", "<S-h>")
keymap.del("n", "<S-l>")


keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")

if jit.os == "OSX" then
	-- Resize window using <ctrl> arrow keys
	keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
	keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
	keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
	keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end

if vim.g.vscode then
	keymap.set("n", "<leader>ff", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
	keymap.set("n", ivim.lsp_keys.Explorer,
		"<Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>")

	keymap.set({ "n", "x" }, ivim.lsp_keys.GotoReferences,
		"<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>")
	keymap.set({ "n", "x" }, ivim.lsp_keys.CodeActions, "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>")
	keymap.set({ "n", "x" }, ivim.lsp_keys.Rename, "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")

	keymap.set({ "n", "x" }, ivim.lsp_keys.GotoTypeDefinition,
		"<Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>")
	keymap.set({ "n", "x" }, ivim.lsp_keys.PeekTypeDefinition,
		"<Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>")

	keymap.set({ "n", "x" }, ivim.lsp_keys.GotoImplementation,
		"<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>")
	keymap.set({ "n", "x" }, ivim.lsp_keys.PeekImplementation,
		"<Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>")

	keymap.set({ "n", "x" }, ivim.lsp_keys.DiagnosticPrev, "<Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>")
	keymap.set({ "n", "x" }, ivim.lsp_keys.DiagnosticNext, "<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>")
end
