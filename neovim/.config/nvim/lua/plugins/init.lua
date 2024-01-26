return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "kylechui/nvim-surround",
    keys = {
      { "<C-g>s", mode = { "i" } },
      { "<C-g>S", mode = { "i" } },
      { "ys", mode = { "n" } },
      { "yss", mode = { "n" } },
      { "yS", mode = { "n" } },
      { "ySS", mode = { "n" } },
      { "S", mode = { "x" } },
      { "gS", mode = { "v" } },
      { "ds", mode = { "n" } },
      { "cs", mode = { "n" } },
    },
    opts = true,
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
