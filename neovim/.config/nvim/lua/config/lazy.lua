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

require("lazy").setup({
  spec = {
    { "folke/lazy.nvim", version = "*" },
    -- 插件目录
    { import = "plugins" },
    {
      import = "plugins.ui",
      enabled = not vim.g.vscode,
    },
    {
      import = "plugins.editor",
      enabled = not vim.g.vscode,
    },
    {
      import = "plugins.coding",
      enabled = not vim.g.vscode,
    },
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "habamax" },
  },
  git = {
    url_format = ivim.git_proxy("https://github.com/%s.git"),
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",

        "tar",
        "tarPlugin",

        "zip",
        "zipPlugin",

        "getscript",
        "getscriptPlugin",

        "vimball",
        "vimball_plugin",
        "2html_plugin",
        "logiPat",
        "rrhelper",

        "matchit",
        -- "matchparen",

        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",

        "tohtml",
        "tutor",
        "zipPlugin",

        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",

        "spellfile",
        "shada",
      },
    },
  },
})

if not vim.g.vscode then
  vim.cmd.colorscheme(ivim.colorscheme)
end

vim.keymap.set("n", "<leader>ll", "<cmd>:Lazy<cr>", { desc = "Lazy" })
