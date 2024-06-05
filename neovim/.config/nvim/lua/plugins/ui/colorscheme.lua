return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = vim.g.transparent_enabled,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 2000,
    opts = {
      -- flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      -- background = { -- :h background
      --   light = "latte",
      -- dark = "mocha",
      -- },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
}
