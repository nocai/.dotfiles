return {
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
      -- 背景透明
      highlights = {
        fill = {
          bg = "none",
        },
        background = {
          bg = "none",
        },
        tab = {
          bg = "none",
        },
        tab_selected = {
          bg = "none",
        },
        tab_separator = {
          bg = "none",
        },
        tab_separator_selected = {
          bg = "none",
        },
        tab_close = {
          bg = "none",
        },
        close_button = {
          bg = "none",
        },
        close_button_visible = {
          bg = "none",
        },
        close_button_selected = {
          bg = "none",
        },
        buffer_visible = {
          bg = "none",
        },
        buffer_selected = {
          bg = "none",
        },
        numbers = {
          bg = "none",
        },
        numbers_visible = {
          bg = "none",
        },
        numbers_selected = {
          bg = "none",
        },
        diagnostic = {
          bg = "none",
        },
        diagnostic_visible = {
          bg = "none",
        },
        diagnostic_selected = {
          bg = "none",
        },
        hint = {
          bg = "none",
        },
        hint_visible = {
          bg = "none",
        },
        hint_selected = {
          bg = "none",
        },
        hint_diagnostic = {
          bg = "none",
        },
        hint_diagnostic_visible = {
          bg = "none",
        },
        hint_diagnostic_selected = {
          bg = "none",
        },
        info = {
          bg = "none",
        },
        info_visible = {
          bg = "none",
        },
        info_selected = {
          bg = "none",
        },
        info_diagnostic = {
          bg = "none",
        },
        info_diagnostic_visible = {
          bg = "none",
        },
        info_diagnostic_selected = {
          bg = "none",
        },
        warning = {
          bg = "none",
        },
        warning_visible = {
          bg = "none",
        },
        warning_selected = {
          bg = "none",
        },
        warning_diagnostic = {
          bg = "none",
        },
        warning_diagnostic_visible = {
          bg = "none",
        },
        warning_diagnostic_selected = {
          bg = "none",
        },
        error = {
          bg = "none",
        },
        error_visible = {
          bg = "none",
        },
        error_selected = {
          bg = "none",
        },
        error_diagnostic = {
          bg = "none",
        },
        error_diagnostic_visible = {
          bg = "none",
        },
        error_diagnostic_selected = {
          bg = "none",
        },
        modified = {
          bg = "none",
        },
        modified_visible = {
          bg = "none",
        },
        modified_selected = {
          bg = "none",
        },
        duplicate_selected = {
          bg = "none",
        },
        duplicate_visible = {
          bg = "none",
        },
        duplicate = {
          bg = "none",
        },
        separator_selected = {
          bg = "none",
        },
        separator_visible = {
          bg = "none",
        },
        separator = {
          bg = "none",
        },
        indicator_visible = {
          bg = "none",
        },
        indicator_selected = {
          bg = "none",
        },
        pick_selected = {
          bg = "none",
        },
        pick_visible = {
          bg = "none",
        },
        pick = {
          bg = "none",
        },
        offset_separator = {
          bg = "none",
        },
        trunc_marker = {
          bg = "none",
        },
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
    },
  },
}
