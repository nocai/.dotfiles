if vim.g.vscode then
  return {}
end

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
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Neotest(Open output)",
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
