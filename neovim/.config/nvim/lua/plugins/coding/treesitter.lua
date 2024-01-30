return {
  {
    "windwp/nvim-ts-autotag",
    opts = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "VeryLazy" },
    opts = {
      ensure_installed = { "lua", "luadoc", "vim", "vimdoc", "markdown", "markdown_inline", "go", "rust" },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      incremental_selection = { enable = false },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- set proxy
      require("nvim-treesitter.install").prefer_git = true
      for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
        config.install_info.url = ivim.git_proxy(config.install_info.url)
      end
    end,
    dependencies = {
      -- {
      --   "HiPhish/rainbow-delimiters.nvim",
      --   opts = true,
      --   -- config = function(_, opts)
      --   --   require("rainbow-delimiters.setup").setup(opts)
      --   -- end,
      -- },
      -- {
      --   "nvim-treesitter/nvim-treesitter-context",
      --   opts = true,
      -- },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    keys = {
      "[",
      "]",
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            include_surrounding_whitespace = true,
            keymaps = {
              ["ia"] = "@parameter.inner",
              ["aa"] = "@parameter.outer",
              ["if"] = "@function.inner",
              ["af"] = "@function.outer",
              ["ic"] = "@class.inner",
              ["ac"] = "@class.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]a"] = "@parameter.outer",
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]A"] = "@parameter.outer",
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[a"] = "@parameter.outer",
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[A"] = "@parameter.outer",
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          lsp_interop = {
            enable = false,
            border = "rounded",
            peek_definition_code = {
              [ivim.keymaps.PeekFunction] = "@function.outer",
              [ivim.keymaps.PeekClass] = "@class.outer",
            },
          },
        },
      })
    end,
  },
}
