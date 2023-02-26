return {
  dap = {
    {
      "<F9>",
      "<leader>db",
      remap = true,
      desc = "DAP(toggle breakpoint)",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "DAP(toggle breakpoint)",
    },

    {
      "<F5>",
      "<leader>dc",
      remap = true,
      desc = "DAP(continue)",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "DAP(continue)",
    },

    {
      "<F10>",
      "<leader>do",
      remap = true,
      desc = "DAP(step over)",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "DAP(step over)",
    },

    {
      "<F11>",
      "<leader>di",
      remap = true,
      desc = "DAP(step into)",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "DAP(step into)",
    },

    {
      "<F12>",
      "<leader>dO",
      remap = true,
      desc = "DAP(step out)",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_out()
      end,
      desc = "DAP(step out)",
    },

    {
      "<F6>",
      "<leader>dl",
      remap = true,
      desc = "DAP(run last)",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "DAP(run last)",
    },

    {
      "<Leader>dB",
      function()
        require("dap").set_breakpoint()
      end,
      desc = "DAP(set breakpoint)",
    },
    {
      "<Leader>dr",
      function()
        require("dap").repl.open()
      end,
      desc = "DAP(REPL open)",
    },
    {
      "<Leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      mode = { "n", "v" },
      desc = "DAP(widgets)",
    },
    {
      "<Leader>dp",
      function()
        require("dap.ui.widgets").preview()
      end,
      mode = { "n", "v" },
      desc = "DAP(widgets preview)",
    },
    {
      "<Leader>df",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end,
      desc = "DAP(frames)",
    },
    {
      "<Leader>ds",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end,
      desc = "DAP(scopes)",
    },
  },

  ["dap-ui"] = {
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "DAP-UI(toggle ui)",
    },
  },

  ["dap-go"] = function()
    local dapgo = require("dap-go")
    return {
      { "<leader>dtc", dapgo.debug_test, desc = "DAP-GO(Debug test: closest method)" },
      { "<leader>dtl", dapgo.debug_last_test, desc = "DAP-GO(Debug test: last method)" },
    }
  end,
}
