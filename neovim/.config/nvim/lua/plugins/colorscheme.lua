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
      style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      -- transparent = true,
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
  },
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    opts = {
      -- transparent_bg = true,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- transparent_background = true,
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
    opts = {
      options = {
        -- transparent = true,
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
      -- transparent = true,
      -- -- Lualine options --
      -- lualine = {
      --   transparent = true, -- lualine center bar transparency
      -- },
    },
  },
}
