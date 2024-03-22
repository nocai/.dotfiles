return {
  {
    "xiyaowong/transparent.nvim",
    enabled = false,
    cmd = { "TransparentEnable", "TransparentDisable", "TransparentToggle" },
    opts = {
      groups = { -- table: default groups
        "Normal",
        "NormalNC",
        -- "Comment",
        -- "Constant",
        -- "Special",
        -- "Identifier",
        -- "Statement",
        -- "PreProc",
        -- "Type",
        -- "Underlined",
        -- "Todo",
        -- "String",
        -- "Function",
        -- "Conditional",
        -- "Repeat",
        -- "Operator",
        -- "Structure",
        -- "LineNr",
        -- "NonText",
        "SignColumn",
        -- "CursorLine",
        -- "CursorLineNr",
        -- "StatusLine",
        -- "StatusLineNC",
        -- "EndOfBuffer",
      },
      extra_groups = {
        -- "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
        -- "NvimTreeNormal", -- NvimTree

        -- "NeoTreeTabActive",
        -- "NeoTreeTabInactive",
        -- "NeoTreeTabSeparatorActive",
        -- "NeoTreeTabSeparatorInactive",
      },
    },
    config = function(_, opts)
      require("transparent").setup(opts)
      vim.g.transparent_groups = vim.list_extend(
        vim.g.transparent_groups or {},
        vim.tbl_map(function(v)
          return v.hl_group
        end, vim.tbl_values(require("bufferline.config").highlights))
      )
    end,
  },
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      transparent = vim.g.transparent_enabled,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
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
