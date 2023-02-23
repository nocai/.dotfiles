-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
-- opt.statusline = "%!v:lua.require('config.statusline').run()"

opt.pumblend = 0
opt.list = false

opt.timeoutlen = 1000

opt.showmode = true -- Dont show mode since we have a statusline
opt.laststatus = 2
