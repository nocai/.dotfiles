return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = not vim.g.vscode,
  branch = "v2.x",
  cmd = "Neotree",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>e",
      "<cmd>Neotree toggle<cr>",
      desc = "Explorer NeoTree (toggle)",
    },
    {
      "<leader>E",
      "<cmd>Neotree reveal_force_cwd<cr>",
      desc = "Explorer NeoTree (focus)",
    },
    {
      "<leader>ge",
      "<cmd>Neotree git_status<cr>",
      desc = "Explorer Git Status",
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    close_if_last_window = true,
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = true,
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
      },
    },
  },
}
