return {
  -- stylua: ignore
  dap = {
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
  -- stylua: ignore
  ["dap-ui"] = {
    { "<F12>", function() require("dapui").toggle() end, desc = "Toggle ui(dap-ui)" },
  },
  -- stylua: ignore
  ["dap-go"] = {
    { "<leader>Dtt", function() require("dap-go").debug_test() end, desc = "Debug test: closest method" },
    { "<leader>Dtl", function() require("dap-go").debug_last_test() end, desc = "Debug test: last method" },
  },
}
