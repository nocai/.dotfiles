return {
  "akinsho/toggleterm.nvim",
  enabled = not vim.g.vscode,
    -- stylua: ignore
    keys = {
      { [[<C-_>]], [[<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>]],
        mode = { "n", "i", "t", "x" }, desc = "Open terminal horizontal",
      },
      {
        [[<C-\>]], [[<Cmd>execute v:count . "ToggleTerm direction=float"<CR>]],
        mode = { "n", "i", "t", "x" }, desc = "Open terminal vertical",
      },
    },
  opts = {
    open_mapping = false, -- [[<C-\>]]
    start_in_insert = true,
    auto_scroll = false,
    float_opts = {
      border = "curved",
    },
    highlights = {
      FloatBorder = {
        link = "FloatBorder",
      },
    },
  },
}
