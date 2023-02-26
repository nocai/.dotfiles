return {
  {
    "mfussenegger/nvim-dap",
    keys = require("plugins.dap.keymaps").dap,
    enabled = not vim.g.vscode,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        keys = require("plugins.dap.keymaps")["dap-ui"],
        config = function()
          local dapui = require("dapui")
          dapui.setup()

          local dap = require("dap")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
          require("telescope").load_extension("dap")
        end,
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
        keys = require("plugins.dap.keymaps")["dap-go"],
      },
    },
    config = function()
      require("dap.ext.vscode").load_launchjs(nil, {})
      vim.notify("load lunchjs from: .vscode/lunchjs.json")
    end,
  },
}
