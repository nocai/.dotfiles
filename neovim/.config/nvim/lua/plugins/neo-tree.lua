return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "mrbjarksen/neo-tree-diagnostics.nvim",
  },
  cmd = { "Neotree" },
  keys = {
    { "<leader>e", "<cmd>Neotree<CR>", desc = "Neotree" },
    { "<leader>E", "<cmd>Neotree reveal_force_cwd<CR>", desc = "Neotree Force" },

    { "<leader>b", "<cmd>Neotree buffers<CR>", desc = "Neotree Buffers" },
    { "<leader>x", "<cmd>Neotree diagnostics<CR>", desc = "Neotree Diagnostics" },
    { "gO", "<cmd>Neotree source=document_symbols<CR>", desc = "Document Symbols" },
  },
  opts = {
    close_if_last_window = true,
    auto_clean_after_session_restore = true,
    popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid", "NC"
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "diagnostics",
      "document_symbols",
    },
    source_selector = {
      winbar = true,
      content_layout = "center",
      -- show_scrolled_off_parent_node = true,
      sources = { -- table
        {
          source = "filesystem", -- string
          display_name = " 󰉓 Files ", -- string | nil
        },
        {
          source = "buffers", -- string
          display_name = " 󰈚 Bufs ", -- string | nil
        },
        {
          source = "git_status", -- string
          display_name = " 󰊢 Git ", -- string | nil
        },
        {
          source = "diagnostics", -- string
          display_name = " X Diags ", -- string | nil
        },
        {
          source = "document_symbols", -- string
          display_name = " @ Symbols ", -- string | nil
        },
      },
      separator = "",
      highlight_tab = "Comment",
      -- highlight_tab_active = "NeoTreeTabActive",
      highlight_background = "NeoTreeNormal",
      highlight_separator = "NeoTreeNormal",
      -- highlight_separator_active = "NeoTreeTabSeparatorActive",
    },
    window = {
      mappings = {
        ["<Tab>"] = "next_source",
        ["<S-Tab>"] = "prev_source",
      },
    },
    filesystem = {
      group_empty_dirs = true,
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    git_status = {
      window = {
        mappings = {
          ["gA"] = "git_add_all",
        },
      },
    },
    diagnostics = {
      group_dirs_and_files = false,
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
        end,
      },
    },
  },
}
