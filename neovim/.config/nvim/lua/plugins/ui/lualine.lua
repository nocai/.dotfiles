return {
    "nvim-lualine/lualine.nvim",
    enabled = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      options = {
        globalstatus = true,
      },
    },
  }
