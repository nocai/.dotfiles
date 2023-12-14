return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      -- set breakpoint
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint(dap)" },
      { "<leader><F9>", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "set breakpoint condition(dap)" },

      -- debuging
      { "<F5>", function() require("dap").continue() end, desc = "Continue(dap)" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step over(dap)" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step into(dap)" },
      { "<leader><F11>", function() require("dap").step_out() end, desc = "Step out(dap)" },

      { "<leader>Dd", function() require("dap").run_to_cursor() end, desc = "Run to Cursor(dap)" },
      { "<leader>D.", function() require("dap").run_last() end, desc = "Run Last(dap)" },
      { "<leader>Dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets(dap)" },
    },
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
          require("mason-nvim-dap").setup({
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,
            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
              -- Update this to ensure that you have the debuggers for the langs you want
              "delve",
            },
          })
          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          -- require('mason-nvim-dap').setup_handlers()
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = { { "<F12>", function() require("dapui").toggle() end, desc = "Toggle ui(dap-ui)" } },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          dapui.setup()
          dap.listeners.after.event_initialized["dapui_config"] = dapui.open
          dap.listeners.before.event_terminated["dapui_config"] = dapui.close
          dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end,
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
        -- stylua: ignore
        keys = {
          { "<leader>Dtt", function() require("dap-go").debug_test() end, desc = "Debug test: closest method" },
          { "<leader>Dtl", function() require("dap-go").debug_last_test() end, desc = "Debug test: last method" },
        },
      },
      -- {
      --   "theHamsta/nvim-dap-virtual-text",
      --   opts = {},
      -- },
    },
    config = function()
      require("dap.ext.vscode").load_launchjs(nil, {})
      vim.notify("load lunchjs from: .vscode/lunchjs.json")
    end,
  },
}
