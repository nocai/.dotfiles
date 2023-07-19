return {
  { "nvim-lua/plenary.nvim" },
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
    -- keys = {
    --   { "<C-g>z", mode = { "i" } },
    --   { "<C-g>Z", mode = { "i" } },
    --   { "yz", mode = { "n" } },
    --   { "yzz", mode = { "n" } },
    --   { "yZ", mode = { "n" } },
    --   { "yZZ", mode = { "n" } },
    --   { "Z", mode = { "v" } },
    --   { "gZ", mode = { "v" } },
    --   { "dz", mode = { "n" } },
    --   { "cz", mode = { "n" } },
    -- },
    -- opts = function()
    --   -- 与leap.nvim冲突
    --   -- s -> z; S -> Z
    --   return {
    --     keymaps = {
    --       insert = "<C-g>z",
    --       insert_line = "<C-g>Z",
    --       normal = "yz",
    --       normal_cur = "yzz",
    --       normal_line = "yZ",
    --       normal_cur_line = "yZZ",
    --       visual = "Z",
    --       visual_line = "gZ",
    --       delete = "dz",
    --       change = "cz",
    --     },
    --   }
    -- end,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward" },
      { "gs", mode = { "n", "x", "o" } },
      { "x", mode = { "x", "o" } },
      { "X", mode = { "x", "o" } },
    },
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {},
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
