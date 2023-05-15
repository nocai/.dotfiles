local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    ivim.git_proxy("https://github.com/folke/lazy.nvim.git"),
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("config.lazy.util").load()
require("lazy").setup({
  spec = {
    { "folke/lazy.nvim", version = "*" },
    -- 插件目录
    { import = "plugins" },
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
        "matchparen",

        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "tarPlugin",
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
