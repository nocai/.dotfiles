if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-tree/nvim-web-devicons",
    enabled = not vim.g.vscode,
  },
  {
    "tweekmonster/startuptime.vim",
    cmd = { "StartupTime" },
    enabled = not vim.g.vscode,
  },
  {
    "akinsho/toggleterm.nvim",
    enabled = not vim.g.vscode,
    keys = {
      {
        [[<C-_>]],
        [[<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>]],
        mode = { "n", "i", "t", "x" },
        desc = "Open terminal horizontal",
      },
      {
        [[<C-\>]],
        [[<Cmd>execute v:count . "ToggleTerm direction=float"<CR>]],
        mode = { "n", "i", "t", "x" },
        desc = "Open terminal vertical",
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
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    enabled = not vim.g.vscode,
    keys = {
      {
        "<leader>p",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek markdown",
      },
    },
    opts = {},
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    keys = {
      { "<leader>gl", ":Glow<cr>", desc = "Glow", silent = true },
    },
    enabled = not vim.g.vscode,
    opts = {
      border = "rounded",
    },
  },
}
