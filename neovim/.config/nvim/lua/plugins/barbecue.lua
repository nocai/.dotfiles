return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  event = "VeryLazy",
  enabled = not vim.g.vscode,
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  opts = {
    kinds = ivim.icons.kinds,
  },
}
