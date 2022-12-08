return {
  {
    -- commons
    { "nanotee/nvim-lua-guide" },
    { "lewis6991/impatient.nvim" },
    { "wbthomason/packer.nvim", opt = true },
    { "nvim-lua/plenary.nvim", module = "plenary" },
    { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
    -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    { "antoinemadec/FixCursorHold.nvim", event = { "CursorHold" } },
  },
  {
    -- treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = { "VimEnter" },
      module = "nvim-treesitter",
      config = function()
        require("plugins.configs.treesitter")
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = { "nvim-treesitter" },
      config = function()
        require("plugins.configs.treesitter").nvim_treesitter_textobjects()
      end,
    },
    {
      "p00f/nvim-ts-rainbow",
      event = { "UIEnter" },
      config = function()
        print("rainbow")
        require("plugins.configs.treesitter").nvim_ts_rainbow()
      end,
    },
    -- {
    --   "nvim-treesitter/nvim-treesitter-context",
    --   after = { "nvim-treesitter" },
    --   config = function()
    --     require("treesitter-context").setup()
    --   end
    -- },
    -- {
    --   "windwp/nvim-ts-autotag",
    --   after = { "nvim-treesitter" },
    --   config = function()
    --     require("plugins.configs.treesitter").nvim_ts_autotag()
    --   end,
    -- },
  },
  {
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
      after = { "nvim-treesitter" },
      config = function()
        require("plugins.configs.lsp").lsp()
      end,
    },
    {
      "simrat39/symbols-outline.nvim",
      keys = { "gO" },
      cmd = { "SymbolsOutline" },
      config = function()
        require("symbols-outline").setup()
        vim.keymap.set("n", "gO", "<cmd>SymbolsOutline<cr>")
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
      ft = { "json", "md", "markdown", "yaml", "go" },
      config = function()
        require("plugins.configs.lsp").null_ls()
      end,
    },
  },
  {
    -- cmp
    {
      "rafamadriz/friendly-snippets",
      event = { "InsertEnter" },
    },
    {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter" },
      config = function()
        require("plugins.configs.cmp").nvim_cmp()
      end,
    },
    {
      "saadparwaiz1/cmp_luasnip",
      after = { "nvim-cmp" },
      requires = {
        "L3MON4D3/LuaSnip",
        after = { "nvim-cmp" },
        wants = { "friendly-snippets" },
        config = function()
          require("plugins.configs.cmp").luasnip()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      after = { "nvim-cmp" },
    },
    {
      "hrsh7th/cmp-nvim-lua",
      after = { "nvim-cmp" },
    },
    {
      "tzachar/cmp-tabnine",
      run = "./install.sh",
      after = { "nvim-cmp" },
      disable = true,
    },
    {
      "hrsh7th/cmp-path",
      after = { "nvim-cmp" },
    },
    {
      "hrsh7th/cmp-buffer",
      after = { "nvim-cmp" },
    },
    {
      "windwp/nvim-autopairs",
      after = { "nvim-cmp" },
      config = function()
        require("plugins.configs.cmp").nvim_autopairs()
      end,
    },
    {
      "abecodes/tabout.nvim",
      after = { "nvim-cmp" },
      wants = { "nvim-treesitter" },
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
    -- {
    --   "hrsh7th/cmp-cmdline",
    --   after = { "nvim-cmp" },
    -- },
  },
  {
    -- telescope
    {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      config = function()
        require("plugins.configs.nvim_telescope").telescope()
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      after = { "telescope.nvim" },
      run = "make",
      config = function()
        require("plugins.configs.nvim_telescope").telescope_fzf_native()
      end,
    },
    {
      "nvim-telescope/telescope-project.nvim",
      after = { "telescope.nvim" },
      config = function()
        require("plugins.configs.nvim_telescope").telescope_project()
      end,
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      after = { "nvim-lspconfig" },
      config = function()
        require("plugins.configs.nvim_telescope").telescope_ui_select()
      end,
    },
    --
    -- others
    {
      "catppuccin/nvim",
      as = "catppuccin",
      event = { "VimEnter" },
      config = function()
        require("catppuccin").setup({
          transparent_background = true,
          integrations = {
            fidget = true,
            symbols_outline = true,
            leap = true,
            indent_blankline = {
              enabled = true,
              colored_indent_levels = true,
            },
          },
        })
        -- vim.cmd([[colorscheme catppuccin]])
      end,
    },
    {
      "folke/tokyonight.nvim",
      event = { "VimEnter" },
      config = function()
        require("tokyonight").setup({
          transparent = true,
          styles = {
            sidebars = "transparent",
            floats = "transparent",
          },
        })
        vim.cmd([[colorscheme tokyonight]])
      end,
    },
    {
      "EdenEast/nightfox.nvim",
      event = { "VimEnter" },
      config = function()
        require("nightfox").setup({
          options = {
            transparent = true,
            styles = {
              comments = "italic",
              functions = "italic,bold",
            },
          },
        })
        -- vim.cmd([[colorscheme nightfox]])
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      keys = { "<Leader><Leader>" },
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
      event = { "UIEnter" },
      config = function()
        require("plugins.configs.lualine")
      end,
    },
    {
      "akinsho/bufferline.nvim",
      event = { "UIEnter" },
      config = function()
        require("plugins.configs.bufferline")
      end,
      requires = {
        "tiagovla/scope.nvim",
        after = { "nvim-treesitter" },
        config = function()
          require("scope").setup()
        end,
      },
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = { "UIEnter" },
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
      ft = { "css", "html" },
      cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers",
        "ColorizerToggle",
      },
      config = function()
        require("colorizer").setup()
      end,
    },
    {
      "kylechui/nvim-surround",
      event = { "VimEnter" },
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
      event = { "UIEnter" },
      config = function()
        require("plugins.configs.misc").gitsigns()
      end,
    },
    {
      "sindrets/diffview.nvim",
      cmd = {
        "DiffviewClose",
        "DiffviewOpen",
        "DiffviewFileHistory",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
        "DiffviewLog",
      },
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
      config = function()
        require("plugins.configs.misc").vim_test()
      end,
    },
    -- {
    --   "klen/nvim-test",
    --   keys = { "<Leader>t" },
    --   config = function()
    --     require("plugins.configs.misc").nvim_test()
    --   end
    -- },
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
  },
}
