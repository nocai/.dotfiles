return {
  { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (telescope)" },
  { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (telescope)" },
  { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help Pages (telescope)" },
  { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History (telescope)" },
  -- resume
  { "<leader>.", "<cmd>Telescope resume<cr>", desc = "Resume (telescope)" },
  { "<leader>,", "<cmd>Telescope<cr>", desc = "Builtin (telescope)" },
  -- find
  { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands (telescope)" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers (telescope)" },
  { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands (telescope)" },
  { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics (telescope)" },
  { "<leader>fh", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups (telescope)" },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps (telescope)" },
  { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages (telescope)" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent (telescope)" },
  { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Options (telescope)" },
  { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word (telescope)" },

  { "<leader>fC", "<cmd>Telescope git_commits<CR>", desc = "Git Commits (telescope)" },
  { "<leader>ff", "<cmd>Telescope git_files<cr>", desc = "Git Files (telescope)" },
  { "<leader>fs", "<cmd>Telescope git_status<CR>", desc = "Git Status (telescope)" },
}
