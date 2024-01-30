return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },

    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
  },
  opts = {
    options = {
      -- stylua: ignore
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
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
    "echasnovski/mini.bufremove",
    {
      "tiagovla/scope.nvim",
      config = true,
    },
  },
}
