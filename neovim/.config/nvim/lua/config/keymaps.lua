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

-- lazy
keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- save file
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
keymap.set("n", "<leader>cs", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "Colorscheme" })

-- -- lazygit
-- keymap.set("n", "<leader>gg", function()
--   require("config.lazy.util").float_term({ "lazygit" }, {
--     cwd = require("config.lazy.util").get_root(),
--   })
-- end, { desc = "Lazygit (root dir)" })
--
-- keymap.set("n", "<leader>gG", function()
--   require("config.lazy.util").float_term({ "lazygit" })
-- end, { desc = "Lazygit" })

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

if vim.g.vscode then
  vim.cmd([[
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
  ]])

  keymap.set("n", "<leader>e", "<Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>")
  keymap.set("n", "<leader><space>", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")

  keymap.set(
    { "n", "x" },
    ivim.lsp_keys.GotoReferences,
    "<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>"
  )
  keymap.set({ "n" }, ivim.lsp_keys.Rename, "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")
  keymap.set({ "n" }, ivim.lsp_keys.CodeLens, "<Cmd>call VSCodeNotify('codelens.showLensesInCurrentLine')<CR>")
  keymap.set({ "n", "x" }, ivim.lsp_keys.CodeActions, "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>")

  keymap.set(
    { "n", "x" },
    ivim.lsp_keys.GotoTypeDefinition,
    "<Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>"
  )
  keymap.set(
    { "n", "x" },
    ivim.lsp_keys.PeekTypeDefinition,
    "<Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>"
  )

  keymap.set(
    { "n", "x" },
    ivim.lsp_keys.GotoImplementation,
    "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>"
  )
  keymap.set(
    { "n", "x" },
    ivim.lsp_keys.PeekImplementation,
    "<Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>"
  )
  keymap.set({ "n", "x" }, ivim.lsp_keys.FormatDocument, "<Cmd>call VSCodeCall('editor.action.formatDocument')<CR>")

  keymap.set({ "n", "x" }, ivim.lsp_keys.DiagnosticPrev, "<Cmd>call VSCodeCall('editor.action.marker.prev')<CR>")
  keymap.set({ "n", "x" }, ivim.lsp_keys.DiagnosticNext, "<Cmd>call VSCodeCall('editor.action.marker.next')<CR>")
end
