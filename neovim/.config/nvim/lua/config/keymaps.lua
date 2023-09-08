-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- better up/down
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "gh", "^", { silent = true })
keymap.set("n", "gl", "$", { silent = true })

keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to the down window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to the up window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })

-- Resize window
keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- buffers
keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- keymap.set("n", "<leader><Tab>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap.set("n", "<Leader><Tab>", "gt", { desc = "Next Tab" })
keymap.set("n", "<Leader><S-Tab>", "gT", { desc = "Prev Tab" })

-- save file
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")

keymap.set("i", "<C-e>", "<End>")
keymap.set("i", "<C-a>", "<Home>")

-- Add undo break-points
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ":", ":<c-g>u")
keymap.set("i", ";", ";<c-g>u")

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Terminal left window navigation" })
keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Terminal down window navigation" })
keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Terminal up window navigation" })
keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Terminal right window navigation" })
