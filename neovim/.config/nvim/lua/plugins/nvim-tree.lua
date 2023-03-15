return {
  {
    "kyazdani42/nvim-tree.lua",
    enabled = false,
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "NvimTree(toggle)" },
      { "<leader>E", "<cmd>NvimTreeFocus<CR>", desc = "NvimTree(focus)" },
    },
    opts = function()
      -- auto close last windows in the tab
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
            vim.cmd("quit")
          end
        end,
      })

      return {
        hijack_cursor = true,
        prefer_startup_root = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        renderer = {
          group_empty = true,
          indent_markers = {
            enable = true,
          },
          icons = {
            git_placement = "after", -- "signcolumn"
          },
        },
        view = {
          adaptive_size = true,
        },
      }
    end,
  },
}
