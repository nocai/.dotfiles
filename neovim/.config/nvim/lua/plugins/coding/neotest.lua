return {
  {
    "nvim-neotest/neotest",
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "Run attach" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tF", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
    dependencies = {
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
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
    },
  },
}
