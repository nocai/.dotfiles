if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-neotest/neotest",
    enabled = not vim.g.vscode,
    keys = {
      {
        "<leader>tc",
        function()
          require("neotest").run.run()
        end,
        desc = "Run the nearest test (neotest)",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Re-run the last position (neotest)",
      },
      {
        "<leader>ts",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop the nearest test (neotest)",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Test the current file (neotest)",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach to the nearest test (neotest)",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Open output (neotest)",
      },
      {
        "<leader>tt",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Test summary toggle (neotest)",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      -- adapters
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-go"),
          require("neotest-rust")({
            args = { "--no-capture" },
          }),
        },
        -- default_strategy = "dap",
      }
    end,
  },
}
