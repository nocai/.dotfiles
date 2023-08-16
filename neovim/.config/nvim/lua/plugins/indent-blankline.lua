return {
  -- indent guides for Neovim
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = not vim.g.vscode,
  opts = {
    char = "│",
    filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = false,
    show_current_context_start = false,
  },
}
