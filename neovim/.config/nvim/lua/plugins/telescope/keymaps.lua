return {
  { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
  { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  { "<leader>.", "<cmd>Telescope resume<cr>", desc = "Resume" },
  -- find
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  -- git
  { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
  { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
  { "<leader>gS", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
  -- search
  { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
  { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
  { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
  { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  { "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word" },
  { "<leader>sC", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Colorscheme" },
  {
    "<leader>ss",
    function()
      require("telescope.builtin").lsp_document_symbols({
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      })
    end,
    desc = "Goto Symbol",
  },
  {
    "<leader>sS",
    function()
      require("telescope.builtin").lsp_workspace_symbols({
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      })
    end,
    desc = "Goto Symbol (Workspace)",
  },
}
