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
      -- styles = {
      -- sidebars = "transparent",
      -- floats = "transparent",
      -- },
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
        cmp = true,
        gitsigns = true,
        neotree = true,
        nvimtree = true,
        treesitter = true,
        mason = true,
        which_key = true,
        rainbow_delimiters = true,
        lsp_trouble = true,
        telescope = {
          enabled = true,
          -- style = "nvchad",
        },
        illuminate = {
          enabled = true,
          lsp = false,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        barbecue = {
          dim_dirname = true, -- directory name is dimmed by default
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
        dap = {
          enabled = true,
          enable_ui = true, -- enable nvim-dap-ui
        },
        fidget = true,
        neotest = true,
        flash = true,
        symbols_outline = true,
        -- leap = true,
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
          -- functions = "italic,bold",
          functions = "italic",
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
