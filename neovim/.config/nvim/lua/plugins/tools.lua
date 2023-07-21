return {
  {
    "tweekmonster/startuptime.vim",
    cmd = { "StartupTime" },
    enabled = not vim.g.vscode,
  },
  {
    "numToStr/Comment.nvim",
    enabled = not vim.g.vscode,
    keys = {
      { "gcc", mode = "n" },
      { "gc", mode = "v" },
      { "gbc", mode = "n" },
      { "gb", mode = "v" },
    },
    opts = {},
  },
  {
    "thinca/vim-quickrun",
    enabled = not vim.g.vscode,
    keys = {
      { "<leader>rr", "<Plug>(quickrun)", desc = "Run code" },
    },
    init = function()
      vim.g.quickrun_no_default_key_mappings = 1
      vim.g.quickrun_config = { _ = { outputter = "message" } }
    end,
  },
  -- {
  -- 	"vim-test/vim-test",
  --  enabled = not vim.g.vscode,
  -- 	keys = {
  -- 		{ "<leader>tt", "<cmd>TestNearest<CR>", desc = "Test nearest" },
  -- 		{ "<leader>tf", "<cmd>TestFile<CR>",    desc = "Test file" },
  -- 		{ "<leader>ts", "<cmd>TestSuite<CR>",   desc = "Test suite" },
  -- 		{ "<leader>tl", "<cmd>TestLast<CR>",    desc = "Test last" },
  -- 		{ "<leader>tv", "<cmd>TestVisit<CR>",   desc = "Test visit" },
  -- 	},
  -- 	config = function()
  -- 		vim.cmd([[let test#strategy = "neovim"]])
  -- 	end,
  -- },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    enabled = not vim.g.vscode,
    keys = {
      {
        "<leader>pp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek markdown",
      },
    },
    opts = {},
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    keys = {
      { "<leader>gl", ":Glow<cr>", desc = "Glow", silent = true },
    },
    enabled = not vim.g.vscode,
    opts = {
      border = "rounded",
    },
  },
}
