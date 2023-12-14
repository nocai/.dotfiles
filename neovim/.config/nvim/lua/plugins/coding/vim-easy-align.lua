return {
  "junegunn/vim-easy-align",
  enabled = not vim.g.vscode,
  keys = {
    { "<leader>ga", "<Plug>(EasyAlign)", mode = { "n", "x" } },
  },
}
