return {
  { "nvim-lua/plenary.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    enabled = not vim.g.vscode,
    keys = {
      -- { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle (NvimTree)" },
      { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus (NvimTree)" },
      { "<leader>E", "<cmd>NvimTreeFindFile!<CR>", desc = "FindFile! (NvimTree)" },
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
          update_root = false,
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
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    },
    enabled = not vim.g.vscode,
    opts = {
      options = {
        indicator = {
          icon = "⏽ ",
        },
        separator_style = { "", "" },
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorer",
            separator = true,
          },
        },
      },
    },
    dependencies = {
      "tiagovla/scope.nvim",
      config = true,
    },
  },
  {
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
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (telescope)" },
      { "<leader><tab>", "<cmd>Telescope buffers<cr>", desc = "Buffers (telescope)" },

      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (telescope)" },
      { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help Pages (telescope)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History (telescope)" },

      -- resume
      { "<leader>.", "<cmd>Telescope resume<cr>", desc = "Resume (telescope)" },
      { "<leader>'", "<cmd>Telescope<cr>", desc = "Builtin (telescope)" },

      -- find
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands (telescope)" },
      { "<leader>fC", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands (telescope)" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics (telescope)" },
      { "<leader>fh", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups (telescope)" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps (telescope)" },
      { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages (telescope)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent (telescope)" },
      { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Options (telescope)" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word (telescope)" },

      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits (telescope)" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files (telescope)" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status (telescope)" },
    },
    opts = {},
  },
  {
    "akinsho/toggleterm.nvim",
    enabled = not vim.g.vscode,
    -- stylua: ignore
    keys = {
      { [[<C-_>]], [[<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>]],
        mode = { "n", "i", "t", "x" }, desc = "Open terminal horizontal",
      },
      {
        [[<C-\>]], [[<Cmd>execute v:count . "ToggleTerm direction=float"<CR>]],
        mode = { "n", "i", "t", "x" }, desc = "Open terminal vertical",
      },
    },
    opts = {
      open_mapping = false, -- [[<C-\>]]
      start_in_insert = true,
      auto_scroll = false,
      float_opts = {
        border = "curved",
      },
      highlights = {
        FloatBorder = {
          link = "FloatBorder",
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = not vim.g.vscode,
    keys = { "<space>" },
    opts = {
      plugins = { spelling = true },
      window = { border = "rounded" },
    },
  },
  {
    "kylechui/nvim-surround",
    keys = {
      { "<C-g>s", mode = { "i" } },
      { "<C-g>S", mode = { "i" } },
      { "ys", mode = { "n" } },
      { "yss", mode = { "n" } },
      { "yS", mode = { "n" } },
      { "ySS", mode = { "n" } },
      { "S", mode = { "v" } },
      { "gS", mode = { "v" } },
      { "ds", mode = { "n" } },
      { "cs", mode = { "n" } },
    },
    opts = {},
    -- keys = {
    --   { "<C-g>z", mode = { "i" } },
    --   { "<C-g>Z", mode = { "i" } },
    --   { "yz", mode = { "n" } },
    --   { "yzz", mode = { "n" } },
    --   { "yZ", mode = { "n" } },
    --   { "yZZ", mode = { "n" } },
    --   { "Z", mode = { "v" } },
    --   { "gZ", mode = { "v" } },
    --   { "dz", mode = { "n" } },
    --   { "cz", mode = { "n" } },
    -- },
    -- opts = function()
    --   -- 与leap.nvim冲突
    --   -- s -> z; S -> Z
    --   return {
    --     keymaps = {
    --       insert = "<C-g>z",
    --       insert_line = "<C-g>Z",
    --       normal = "yz",
    --       normal_cur = "yzz",
    --       normal_line = "yZ",
    --       normal_cur_line = "yZZ",
    --       visual = "Z",
    --       visual_line = "gZ",
    --       delete = "dz",
    --       change = "cz",
    --     },
    --   }
    -- end,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward" },
      { "gs", mode = { "n", "x", "o" } },
      { "x", mode = { "x", "o" } },
      { "X", mode = { "x", "o" } },
    },
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
