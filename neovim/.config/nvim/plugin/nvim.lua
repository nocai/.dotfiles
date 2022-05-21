-- terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<M-n>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-e>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-i>", "<C-\\><C-n><C-w>l")

-- Resize splits with arrow keys
vim.keymap.set("n", "<Up>", "<cmd>res +5<cr>")
vim.keymap.set("n", "<Down>", "<cmd>res -5<cr>")
vim.keymap.set("n", "<Left>", "<cmd>vertical resize-5<cr>")
vim.keymap.set("n", "<Right>", "<cmd>vertical resize+5<cr>")

-- buffers
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "]B", "<cmd>blast<cr>")
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")
vim.keymap.set("n", "[B", "<cmd>bfirst<cr>")

vim.keymap.set("", "<C-s>", "<cmd>wall<cr>")
