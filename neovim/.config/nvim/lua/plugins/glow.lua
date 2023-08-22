return {
  "ellisonleao/glow.nvim",
  cmd = "Glow",
  -- keys = {
  --   { "<leader>pg", ":Glow<cr>", desc = "Glow", silent = true },
  -- },
  enabled = not vim.g.vscode,
  opts = {
    border = "rounded",
  },
}
