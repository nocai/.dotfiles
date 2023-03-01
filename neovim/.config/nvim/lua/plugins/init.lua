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
    keys = { { [[<C-\>]], desc = "toggleterm" } },
    enabled = not vim.g.vscode,
    opts = {
      open_mapping = [[<C-\>]],
      direction = "float",
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
}
