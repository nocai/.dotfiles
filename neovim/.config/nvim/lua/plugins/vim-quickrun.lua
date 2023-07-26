return {
  "thinca/vim-quickrun",
  enabled = not vim.g.vscode,
  keys = {
    { "<leader>rr", "<Plug>(quickrun)", desc = "Run code" },
  },
  init = function()
    vim.g.quickrun_no_default_key_mappings = 1
    vim.g.quickrun_config = { _ = { outputter = "message" } }
  end,
}
