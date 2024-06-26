---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    -- stylua: ignore
    -- keys = {
    --   -- set breakpoint
    --   { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint(dap)" },
    --   { "<leader><F9>", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "set breakpoint condition(dap)" },
    --
    --   -- debuging
    --   { "<F5>", function() require("dap").continue() end, desc = "Continue(dap)" },
    --   { "<F10>", function() require("dap").step_over() end, desc = "Step over(dap)" },
    --   { "<F11>", function() require("dap").step_into() end, desc = "Step into(dap)" },
    --   { "<leader><F11>", function() require("dap").step_out() end, desc = "Step out(dap)" },
    --
    --   { "<leader>Dd", function() require("dap").run_to_cursor() end, desc = "Run to Cursor(dap)" },
    --   { "<leader>D.", function() require("dap").run_last() end, desc = "Run Last(dap)" },
    --   { "<leader>Dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets(dap)" },
    -- },
    -- stylua: ignore
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },

      { "<leader>dd", function() require("dap").continue() end, desc = "Start Debug" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Start Debug with Args" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dn", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },

      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },

      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dS", function() require("dap").session() end, desc = "Session" },
      { "<leader>ds", function() require("dap").terminate() end, desc = "Terminate" }, -- <leader>dt 被用于debug test
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
        keys = {
          { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          dapui.setup()
          dap.listeners.after.event_initialized["dapui_config"] = dapui.open
          dap.listeners.before.event_terminated["dapui_config"] = dapui.close
          dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end,
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
        -- stylua: ignore
        keys = {
          { "<leader>dtt", function() require("dap-go").debug_test() end, desc = "Debug test: closest method" },
          { "<leader>dtl", function() require("dap-go").debug_last_test() end, desc = "Debug test: last method" },
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    config = function()
      -- require("dap.ext.vscode").load_launchjs(nil, {})
      -- vim.notify("load lunchjs from: .vscode/lunchjs.json")
    end,
  },
}
