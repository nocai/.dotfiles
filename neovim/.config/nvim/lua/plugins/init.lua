return {
  -- commons
  { "lewis6991/impatient.nvim" },
  { "nvim-lua/plenary.nvim", module = "plenary" },
  { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
  {
    "wbthomason/packer.nvim",
    cmd = {
      "PackerSnapshot",
      "PackerSnapshotRollback",
      "PackerSnapshotDelete",
      "PackerInstall",
      "PackerUpdate",
      "PackerSync",
      "PackerClean",
      "PackerCompile",
      "PackerStatus",
      "PackerProfile",
      "PackerLoad",
    },
  },
  {
    "nanotee/nvim-lua-guide",
    opt = true,
    setup = function()
      local augroup = "LazyLoad:" .. vim.fn.rand()
      vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup(augroup, {}),
        callback = function()
          vim.api.nvim_del_augroup_by_name(augroup)
          vim.defer_fn(function()
            ---@diagnostic disable-next-line: different-requires
            require("packer").loader("nvim-lua-guide")
          end, 0)
        end,
      })
    end,
  },
  {
    -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    "antoinemadec/FixCursorHold.nvim",
    after = { "nvim-lua-guide" },
  },

  --
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = {
      "TSInstall",
      "TSBufEnable",
      "TSBufDisable",
      "TSEnable",
      "TSDisable",
      "TSModuleInfo",
    },
    run = ":TSUpdate",
    event = "VimEnter",
    module = "nvim-treesitter",
    config = function()
      require("plugins.configs.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = { "nvim-treesitter", "nvim-lua-guide" },
    config = function()
      require("plugins.configs.treesitter").nvim_treesitter_textobjects()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = { "nvim-treesitter", "nvim-lua-guide" },
    config = function()
      require("treesitter-context").setup()
    end
  },
  {
    "p00f/nvim-ts-rainbow",
    after = { "nvim-treesitter" },
    config = function()
      require("plugins.configs.treesitter").nvim_ts_rainbow()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    after = { "nvim-treesitter", "nvim-lua-guide" },
    config = function()
      require("plugins.configs.treesitter").nvim_ts_autotag()
    end,
  },

  --
  -- lsp
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = function()
      require("plugins.configs.lsp").mason()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require("plugins.configs.lsp").lsp()
    end,
  },
  {
    -- config, see: ftplugin/java.lua
    "mfussenegger/nvim-jdtls",
    ft = "java",
    after = { "nvim-lspconfig" },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    disable = true,
    after = { "nvim-lua-guide" },
    config = function()
      require("plugins.configs.lsp").null_ls()
    end,
  },

  --
  -- cmp
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("plugins.configs.cmp")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    after = { "nvim-cmp" },
    wants = "friendly-snippets",
    config = function()
      require("plugins.configs.cmp").luasnip()
    end,
  },
  {
    "hrsh7th/cmp-buffer",
    after = { "nvim-cmp" },
  },
  {
    "hrsh7th/cmp-path",
    after = { "nvim-cmp" },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    after = { "nvim-cmp" },
  },
  {
    "saadparwaiz1/cmp_luasnip",
    after = { "nvim-cmp" },
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    after = { "nvim-cmp" },
    disable = true,
  },
  -- {
  -- 	"hrsh7th/cmp-nvim-lua",
  -- 	after = {"nvim-cmp"},
  -- },
  -- {
  -- 	"hrsh7th/cmp-cmdline",
  -- 	after = {"nvim-cmp"},
  -- },
  {
    "windwp/nvim-autopairs",
    after = { "nvim-cmp" },
    config = function()
      require("plugins.configs.cmp").nvim_autopairs()
    end,
  },
  {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
    after = { "nvim-cmp" },
    config = function()
      require("tabout").setup({
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
          { open = "<", close = ">" },
          { open = "#", close = "]" },
        },
      })
    end,
  },

  --
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    after = { "nvim-lua-guide" },
    config = function()
      require("plugins.configs.telescope").telescope()
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    after = { "telescope.nvim" },
    run = "make",
    config = function()
      require("plugins.configs.telescope").telescope_fzf_native()
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    after = { "telescope.nvim" },
    config = function()
      require("plugins.configs.telescope").telescope_ui_select()
    end,
  },
  -- {
  -- 	"ahmedkhalf/project.nvim",
  --  keys = { "<C-k>p", "<C-k><C-p>" },
  -- 	config = function()
  -- 		require("plugins.configs.telescope").project()
  -- 	end,
  -- },
  {
    "nvim-telescope/telescope-project.nvim",
    keys = { "<C-k>p", "<C-k><C-p>" },
    config = function()
      require("plugins.configs.telescope").telescope_project()
    end,
  },
  {
    "folke/todo-comments.nvim",
    keys = { "<C-k>t", "<C-k><C-t>" },
    config = function()
      require("plugins.configs.telescope").todo_comments()
    end,
  },

  --
  -- others
  {
    "folke/tokyonight.nvim",
    after = { "nvim-treesitter" },
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    after = { "nvim-treesitter" },
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            functions = "italic,bold",
          }
        },
      })
      -- vim.cmd([[colorscheme nightfox]])
    end
  },
  {
    "kyazdani42/nvim-tree.lua",
    after = { "nvim-web-devicons" },
    config = function()
      require("plugins.configs.nvim_tree")
    end,
  },
  {
    "ggandor/leap.nvim",
    keys = { "s", "S", "gs", { "v", "x" }, { "o", "x" } },
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "hoob3rt/lualine.nvim",
    after = { "tokyonight.nvim" },
    config = function()
      require("plugins.configs.lualine")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    after = { "nvim-lua-guide" },
    setup = function()
      vim.g.indent_blankline_char = "┊"
      vim.g.indent_blankline_show_first_indent_level = false
    end,
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    keys = { { "n", "gc" }, { "n", "gb" }, { "v", "gc" }, { "v", "gb" } },
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    after = { "nvim-lua-guide" },
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    after = { "nvim-lua-guide" },
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-Space>]], "<Leader>gg", [[<C-\>]] },
    cmd = { "Glow", "Lazygit", "TermExec" },
    module = "toggleterm",
    config = function()
      require("plugins.configs.misc").toggleterm()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    after = { "nvim-lua-guide" },
    config = function()
      require("plugins.configs.misc").gitsigns()
    end,
  },
  {
    "tweekmonster/startuptime.vim",
    cmd = { "StartupTime" },
  },
  {
    "junegunn/vim-easy-align",
    keys = { "<leader>gq" },
    config = function()
      vim.keymap.set({ "n", "x" }, "<Leader>gq", "<Plug>(EasyAlign)")
    end,
  },

  {
    "thinca/vim-quickrun",
    keys = { "<Leader>r" },
    config = function()
      require("plugins.configs.misc").vim_quickrun()
    end,
  },
  {
    "vim-test/vim-test",
    keys = { "<Leader>t" },
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      require("plugins.configs.misc").vim_test()
    end,
  },
  {
    "michaeljsmith/vim-indent-object",
    keys = {
      { "o", "ii" },
      { "o", "ai" },
      { "o", "iI" },
      { "o", "aI" },
      { "v", "ii" },
      { "v", "ai" },
      { "v", "iI" },
      { "v", "aI" },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = { "y", "p", "P", "gp", "gP" },
    config = function()
      require("plugins.configs.misc").yanky()
    end
  },
  {
    "chentoast/marks.nvim",
    keys = { "m" },
    config = function()
      require("plugins.configs.misc").marks()
    end
  }
}
