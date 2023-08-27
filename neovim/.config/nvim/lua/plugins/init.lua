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
    "folke/which-key.nvim",
    enabled = not vim.g.vscode,
    keys = { "<space>" },
    opts = {
      plugins = { spelling = true },
      window = { border = "rounded" },
    },
  },
  {
    "kylechui/nvim-surround",
    keys = {
      { "<C-g>s", mode = { "i" } },
      { "<C-g>S", mode = { "i" } },
      { "ys", mode = { "n" } },
      { "yss", mode = { "n" } },
      { "yS", mode = { "n" } },
      { "ySS", mode = { "n" } },
      { "S", mode = { "v" } },
      { "gS", mode = { "v" } },
      { "ds", mode = { "n" } },
      { "cs", mode = { "n" } },
    },
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    enabled = false,
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
