-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.mouse = "a"
opt.showmode = false
opt.grepprg = "rg --vimgrep"
opt.clipboard = "unnamedplus"
-- Numbers
opt.number = true
opt.relativenumber = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- disable nvim intro
opt.shortmess:append("sI")

opt.cursorline = true

opt.ignorecase = true
opt.smartcase = true

opt.scrolloff = 5 -- Lines of context
opt.sidescrolloff = 10 -- Columns of context

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true

opt.updatetime = 250
opt.timeoutlen = 300

opt.pumheight = 10 -- Maximum number of entries in a popup

opt.undofile = true

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end
