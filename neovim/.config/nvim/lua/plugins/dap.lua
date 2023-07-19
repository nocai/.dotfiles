if vim.g.vscode then
  return {}
end

return {
  {
    "mfussenegger/nvim-dap",
    keys = require("plugins.dap.keymaps").dap,
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
        keys = require("plugins.dap.keymaps")["dap-ui"],
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          dapui.setup()
          dap.listeners.after.event_initialized["dapui_config"] = dapui.open
          dap.listeners.before.event_terminated["dapui_config"] = dapui.close
          dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end,
      },
      -- {
      --   "theHamsta/nvim-dap-virtual-text",
      --   opts = {},
      -- },
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
