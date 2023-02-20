-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

if jit.os == "OSX" then
	-- Resize window using <ctrl> arrow keys
	map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
	map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
	map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
	map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end