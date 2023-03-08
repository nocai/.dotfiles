return {
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-tree/nvim-web-devicons",
    enabled = not vim.g.vscode,
  },
  {
    "tweekmonster/startuptime.vim",
    cmd = { "StartupTime" },
    enabled = not vim.g.vscode,
  },
  {
    "akinsho/toggleterm.nvim",
    enabled = not vim.g.vscode,
    keys = {
      {
        [[<C-_>]],
        [[<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>]],
        mode = { "n", "i", "t", "x" },
        desc = "Open terminal horizontal",
      },
      {
        [[<C-\>]],
        [[<Cmd>execute v:count . "ToggleTerm direction=float"<CR>]],
        mode = { "n", "i", "t", "x" },
        desc = "Open terminal vertical",
      },
    },
    opts = {
      open_mapping = false, -- [[<C-\>]]
      start_in_insert = true,
      auto_scroll = false,
      float_opts = {
        border = "curved",
      },
      highlights = {
        FloatBorder = {
          link = "FloatBorder",
        },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    keys = {
      { "<C-g>z", mode = { "i" } },
      { "<C-g>Z", mode = { "i" } },
      { "yz", mode = { "n" } },
      { "yzz", mode = { "n" } },
      { "yZ", mode = { "n" } },
      { "yZZ", mode = { "n" } },
      { "Z", mode = { "v" } },
      { "gZ", mode = { "v" } },
      { "dz", mode = { "n" } },
      { "cz", mode = { "n" } },
    },
    opts = function()
      -- 与leap.nvim冲突
      -- s -> z; S -> Z
      return {
        keymaps = {
          insert = "<C-g>z",
          insert_line = "<C-g>Z",
          normal = "yz",
          normal_cur = "yzz",
          normal_line = "yZ",
          normal_cur_line = "yZZ",
          visual = "Z",
          visual_line = "gZ",
          delete = "dz",
          change = "cz",
        },
      }
    end,
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" } },
      { "S", mode = { "n", "x", "o" } },
      { "gs", mode = { "n", "x", "o" } },
      { "x", mode = { "x", "o" } },
      { "X", mode = { "x", "o" } },
    },
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    enabled = not vim.g.vscode,
    keys = {
      {
        "<leader>gp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek markdown",
      },
    },
    opts = {},
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    keys = {
      { "<leader>gl", ":Glow<cr>", desc = "Glow", silent = true },
    },
    enabled = not vim.g.vscode,
    opts = {
      border = "rounded",
    },
  },
}
