return {
  "numToStr/Comment.nvim",
  enabled = not vim.g.vscode,
  keys = {
    { "gc", mode = { "n", "v" } },
    { "gb", mode = { "n", "v" } },
  },
  opts = {},
}
