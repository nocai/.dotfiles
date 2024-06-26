return {
  git = {
    url_format = ivim.git_proxy("https://github.com/%s.git"),
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
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
}
