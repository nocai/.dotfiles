return {
  "nvim-telescope/telescope.nvim",
  version = false, -- telescope did only one release, so use HEAD for now
  cmd = "Telescope",
  enabled = not vim.g.vscode,
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  keys = {
    { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },

    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },

    { "<leader>.", "<cmd>Telescope resume<cr>", desc = "[.]Resume" },
    { "<leader>'", "<cmd>Telescope marks<cr>", desc = "[']Marks" },
    { '<leader>"', "<cmd>Telescope<cr>", desc = '["]Builtin' },

    -- find
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[F]ind [B]uffers" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands (telescope)" },
    { "<leader>fC", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands (telescope)" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics (telescope)" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (telescope)" },
    { "<leader>fh", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups (telescope)" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps (telescope)" },
    { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages (telescope)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Options (telescope)" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word (telescope)" },

    -- git
    -- { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits (telescope)" },
    -- { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files (telescope)" },
    -- { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status (telescope)" },
  },
  opts = {},
}
