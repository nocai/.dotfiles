if vim.g.vscode then
  return {}
end

return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    },
    enabled = false,
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
