-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.pumblend = 0
opt.list = false
opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←" --,space:⋅"

opt.timeoutlen = 1000
