return {
  "nvim-telescope/telescope.nvim",
  version = false, -- telescope did only one release, so use HEAD for now
  cmd = "Telescope",
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
    { "<leader>,", "<cmd>Telescope<cr>", desc = "Telescope Builtin" },
    { "<leader>.", "<cmd>Telescope resume<cr>", desc = "Telescope Resume" },

    { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader><tab>", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },

    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>'", "<cmd>Telescope marks<cr>", desc = "Marks" },

    -- { "<leader>uc", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "[U]I [C]olorscheme" },

    -- find
    -- { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find [B]uffers" },
    -- { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "[C]ommands" },
    -- { "<leader>fC", "<cmd>Telescope autocommands<cr>", desc = "Auto [C]ommands" },
    -- { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "[D]iagnostics" },
    -- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find [F]iles" },
    -- { "<leader>fh", "<cmd>Telescope highlights<cr>", desc = "[H]ighlight Groups" },
    -- { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "[K]ey Maps" },
    -- { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "[M]an Pages" },
    -- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[R]ecent Files" },
    -- { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "[O]ptions" },
    -- { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "[W]ord" },

    -- git
    -- { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits (telescope)" },
    -- { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files (telescope)" },
    -- { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status (telescope)" },
  },
  opts = true,
}
