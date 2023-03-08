return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    -- lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        -- local opts = require("config.lazy.util").opts("tokyonight.nvim")
        -- if opts.transparent then
        --   -- statusline 透明
        -- colors.bg_statusline = colors.none
        -- end
      end,
    },
    -- config = function(_, opts)
    --   require("tokyonight").setup(opts)
    --   vim.cmd.colorscheme("tokyonight")
    -- end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = not vim.g.vscode,
    opts = {
      transparent_background = true,
      integrations = {
        fidget = true,
        symbols_outline = true,
        leap = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = not vim.g.vscode,
    opts = {
      options = {
        transparent = true,
        styles = {
          comments = "italic",
          functions = "italic,bold",
        },
      },
    },
  },
  { -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
  },
}
