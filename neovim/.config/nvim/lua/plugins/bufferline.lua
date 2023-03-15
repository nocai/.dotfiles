return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
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
            text = "File Explorer",
          },
          {
            filetype = "NvimTree",
            text = "File Explorer",
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
