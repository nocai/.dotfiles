if vim.g.vscode then
  return {}
end

return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      transparent = true,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
      -- terminal_colors = not vim.g.vscode,
      -- on_colors = function(colors)
      -- local opts = require("config.lazy.util").opts("tokyonight.nvim")
      -- if opts.transparent then
      -- statusline 透明
      -- colors.bg_statusline = colors.none
      -- end
      -- end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
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
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
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
    opts = {
      transparent = true,
      -- Lualine options --
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      vim.cmd.colorscheme("onedark")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          -- TelescopeTitle = { fg = theme.ui.special, bold = true },
          -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { bg = "none" },
          -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { bg = "none" },
          -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          TelescopePreviewBorder = { fg = "none" },
        }
      end,
    },
  },
}
