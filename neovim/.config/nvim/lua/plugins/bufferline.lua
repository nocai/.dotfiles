return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
  },
  enabled = not vim.g.vscode,
  opts = {
    options = {
      indicator = {
        icon = "⏽ ",
      },
      separator_style = { "", "" },
      offsets = {
        {
          filetype = "NvimTree",
          -- text = "NvimTree Explorer",
          separator = true,
          -- padding = 1,
        },
        {
          filetype = "neo-tree",
          text = "Neotree",
          padding = 1,
        },
      },
    },
  },
  dependencies = {
    "tiagovla/scope.nvim",
    config = true,
  },
}
