return {
  { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
  { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
  { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  -- resume
  { "<leader>.", "<cmd>Telescope resume<cr>", desc = "Resume" },
  { "<leader>,", "<cmd>Telescope<cr>", desc = "Builtin" },
  -- find
  { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
  { "<leader>fh", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word" },

  { "<leader>fC", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
  { "<leader>ff", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
  { "<leader>fs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
}
