return {
  {
    "akinsho/bufferline.nvim",
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
            text = "",
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
