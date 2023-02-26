-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")

-- better up/down
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- windows
keymap.set("n", "<M-h>", "<C-w><C-h>", { desc = "Go to left window" })
keymap.set("n", "<M-j>", "<C-w><C-j>", { desc = "Go to lower window" })
keymap.set("n", "<M-k>", "<C-w><C-k>", { desc = "Go to upper window" })
keymap.set("n", "<M-l>", "<C-w><C-l>", { desc = "Go to right window" })

-- Resize window
keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- buffers
keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Add undo break-points
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")

-- save file
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- lazy
keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- lazygit
keymap.set("n", "<leader>gg", function()
  require("config.lazy.util").float_term({ "lazygit" }, { cwd = require("plugins.telescope.util").get_root() })
end, { desc = "Lazygit (root dir)" })
keymap.set("n", "<leader>gG", function()
  require("config.lazy.util").float_term({ "lazygit" })
end, { desc = "Lazygit (cwd)" })

-- toggle
keymap.set("n", [[\d]], require("plugins.lsp.util").toggle_diagnostics, { desc = "Toggle Diagnostics" })
keymap.set("n", [[\f]], require("plugins.lsp.format").toggle, { desc = "Toggle format on Save" })

if jit.os == "OSX" then
  -- Resize window using <ctrl> arrow keys
  keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end

if vim.g.vscode then
  vim.cmd([[
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
  ]])

  keymap.set("n", "<leader>ff", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
  keymap.set(
    "n",
    ivim.lsp_keys.Explorer,
    "<Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>"
  )

  keymap.set(
    { "n", "x" },
    ivim.lsp_keys.GotoReferences,
    "<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>"
  )
  keymap.set({ "n", "x" }, ivim.lsp_keys.CodeActions, "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>")
  keymap.set({ "n", "x" }, ivim.lsp_keys.Rename, "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")

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

  keymap.set({ "n", "x" }, ivim.lsp_keys.DiagnosticPrev, "<Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>")
  keymap.set({ "n", "x" }, ivim.lsp_keys.DiagnosticNext, "<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>")
end
