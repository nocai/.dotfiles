if vim.g.vscode then
  return {}
end

return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      -- transparent = true,
      styles = {
        -- sidebars = "transparent",
        floats = "transparent",
      },
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
    priority = 1000,
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
      -- lualine = {
      --   transparent = true,
      -- },
    },
  },
}
