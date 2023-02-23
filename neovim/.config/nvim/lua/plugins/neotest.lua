return {
  {
    "nvim-neotest/neotest",
    enabled = not vim.g.vscode,
    keys = {
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Neotest(Summary toggle)",
      },
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Neotest(Run the nearest test)",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Neotest(Stop the nearest test)",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Neotest(Run the current file)",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Neotest(Attach to the nearest test)",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Neotest(Re-run the last position)",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go"),
        },
      })
    end,
  },
  {
    "nvim-neotest/neotest-go",
    enabled = not vim.g.vscode,
    ft = "go",
  },
  {
    "rouge8/neotest-rust",
    enabled = not vim.g.vscode,
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rust")({
            args = { "--no-capture" },
          }),
        },
      })
    end,
  },
}
