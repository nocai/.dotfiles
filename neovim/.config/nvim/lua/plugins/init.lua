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
    event = { "VeryLazy" },
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
}
