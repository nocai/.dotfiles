require("config")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    ivim.git_proxy("https://github.com/folke/lazy.nvim.git"),
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
local lazy_config = require("config.lazy")
require("lazy").setup({
  { "folke/lazy.nvim", version = "*" },
  -- 插件目录
  { import = "plugins" },
}, lazy_config)

vim.cmd.colorscheme("tokyonight")
vim.keymap.set("n", "<leader>ll", "<cmd>:Lazy<cr>", { desc = "Lazy" })
