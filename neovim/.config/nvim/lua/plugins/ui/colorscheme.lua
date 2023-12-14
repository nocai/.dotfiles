return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
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
    -- config = function(_, opts)
    --   require("transparent").setup(opts)
    --   vim.g.transparent_groups = vim.list_extend(
    --     vim.g.transparent_groups or {},
    --     vim.tbl_map(function(v)
    --       return v.hl_group
    --     end, vim.tbl_values(require("bufferline.config").highlights))
    --   )
    -- end,
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
    "Mofiqul/dracula.nvim",
    priority = 1000,
    opts = {
      transparent_bg = vim.g.transparent_enabled,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = vim.g.transparent_enabled,
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
        transparent = vim.g.transparent_enabled,
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
      transparent = vim.g.transparent_enabled,
      lualine = {
        transparent = vim.g.transparent_enabled,
      },
    },
  },
}
