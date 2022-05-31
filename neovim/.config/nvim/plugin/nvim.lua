-- windows
vim.keymap.set("n", "<M-h>", "<C-w><C-h>")
vim.keymap.set("n", "<M-n>", "<C-w><C-j>")
vim.keymap.set("n", "<M-e>", "<C-w><C-k>")
vim.keymap.set("n", "<M-i>", "<C-w><C-l>")

-- terminal mode
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-n>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-e>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-i>", "<C-\\><C-n><C-w>l")

-- Resize splits with arrow keys
vim.keymap.set("n", "<Up>", "<cmd>res +5<cr>")
vim.keymap.set("n", "<Down>", "<cmd>res -5<cr>")
vim.keymap.set("n", "<Left>", "<cmd>vertical resize-5<cr>")
vim.keymap.set("n", "<Right>", "<cmd>vertical resize+5<cr>")

-- buffers
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "]b", "<cmd>blast<cr>")
vim.keymap.set("n", "[b", "<cmd>bfirst<cr>")
