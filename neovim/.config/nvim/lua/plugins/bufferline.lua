return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    enabled = not vim.g.vscode,
    opts = {
      options = {
        indicator = {
          icon = "⏽",
        },
        separator_style = { "", "" },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
          },
          {
            filetype = "NvimTree",
            text = "Explorer",
          },
        },
      },
    },
    dependencies = {
      "tiagovla/scope.nvim",
      config = true,
    },
  },
}
