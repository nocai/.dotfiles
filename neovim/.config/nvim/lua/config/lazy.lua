local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "tokyonight",
        map_keys = {
          Explorer = "<leader><space>",

          GotoDefinition = "gd",
          PeekDefinition = "gD",

          GotoTypeDefinition = "gy",
          PeekTypeDefinition = "gY",

          GotoImplementation = "gI",
          PeekImplementation = "<leader>gI",

          GotoReferences = "<leader>gr",
          GotoSymbols = "<leader>gs",
          CodeActions = "<leader>ca",
          FormatDocument = "<leader>cf",
          Rename = "<leader>cr",

          DiagnosticPrev = "[d",
          DiagnosticNext = "]d",
        }
      },
      import = "lazyvim.plugins",
    },
    -- 用于覆盖LazyVim原有的配置
    { import = "plugins.lazyvim" },
    -- 自己的配置文件目录
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "catppuccin" } },
  ui = { border = "rounded" },
  -- checker = { enabled = true }, -- automatically check for plugin updates
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
      },
    },
  },
})
