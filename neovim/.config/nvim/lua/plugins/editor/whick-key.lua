return {
  "folke/which-key.nvim",
  enabled = not vim.g.vscode,
  keys = { "<space>" },
  opts = {
    plugins = { spelling = true },
    window = { border = "rounded" },
  },
}
