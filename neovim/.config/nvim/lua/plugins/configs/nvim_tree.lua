-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  hijack_cursor = true,

  reload_on_bufenter = true,
  create_in_closed_folder = true,
  diagnostics = nvim.diagnostics,

  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  prefer_startup_root = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },

  renderer = {
    group_empty = true,
    -- highlight_opened_files = "name",
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
})

vim.keymap.set("n", "<leader><leader>", "<cmd>NvimTreeFindFileToggle<CR>")

-- auto close last windows in the tab
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})
