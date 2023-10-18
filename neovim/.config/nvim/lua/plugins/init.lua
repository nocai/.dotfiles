return {
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-tree/nvim-web-devicons",
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
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      options = {
        globalstatus = true,
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    enabled = not vim.g.vscode,
    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        enabled = true,
        show_start = false,
      },
    },
  },
  {
    "michaeljsmith/vim-indent-object",
    keys = {
      { "ii", mode = { "o", "x" } },
      { "iI", mode = { "o", "x" } },
      { "ai", mode = { "o", "x" } },
      { "aI", mode = { "o", "x" } },
    },
  },
}
