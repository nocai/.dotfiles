return {
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
    -- stylua: ignore
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    -- enabled = false,
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
      highlights = {
        fill = { bg = "none" },
        offset_separator = { bg = "none" },
        background = { bg = "none" },
        close_button = { bg = "none" },
        buffer_visible = { bg = "none" },
        close_button_visible = { bg = "none" },
        indicator_visible = { bg = "none" },
        separator = { bg = "none" },
        trunc_marker = { bg = "none" },
        modified = { bg = "none" },
        modified_visible = { bg = "none" },
      },
      options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        indicator = {
          icon = " ⏽ ",
        },
        -- separator_style = { "", "" },
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
      {
        "tiagovla/scope.nvim",
        config = true,
      },
    },
  },
}
