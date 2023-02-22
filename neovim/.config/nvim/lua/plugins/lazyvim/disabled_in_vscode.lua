return {
  -- by enabled
  {
    "SmiteshP/nvim-navic",
    enabled = not vim.g.vscode,
  },
  {
    "L3MON4D3/LuaSnip",
    enabled = not vim.g.vscode,
  },
  {
    "folke/which-key.nvim",
    enabled = not vim.g.vscode,
    opts = {
      window = {
        border = "rounded",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "RRethy/vim-illuminate",
    enabled = not vim.g.vscode,
  },
  {
    "folke/trouble.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "folke/todo-comments.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "stevearc/dressing.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "goolord/alpha-nvim",
    enabled = not vim.g.vscode,
  },
  {
    "nvim-tree/nvim-web-devicons",
    enabled = not vim.g.vscode,
  },
  {
    "MunifTanjim/nui.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "dstein64/vim-startuptime",
    enabled = not vim.g.vscode,
  },
  {
    "folke/persistence.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = not vim.g.vscode,
  },
}
