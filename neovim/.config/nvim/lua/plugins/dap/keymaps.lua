return {
  dap = {
    {
      "<F9>",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "toggle breakpoint(dap)",
    },
    {
      "<leader><F9>",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "set breakpoint condition(dap)",
    },
    -- {
    --   "<leader>db",
    --   function()
    --     require("dap").toggle_breakpoint()
    --   end,
    --   desc = "DAP(toggle breakpoint)",
    -- },
    -- {
    --   "<Leader>dB",
    --   function()
    --     require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    --   end,
    --   desc = "DAP(set breakpoint condition)",
    -- },

    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "continue(dap)",
    },
    -- {
    --   "<leader>dc",
    --   function()
    --     require("dap").continue()
    --   end,
    --   desc = "DAP(continue)",
    -- },

    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "step over(dap)",
    },
    -- {
    --   "<leader>do",
    --   function()
    --     require("dap").step_over()
    --   end,
    --   desc = "DAP(step over)",
    -- },

    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "step into(dap)",
    },
    -- {
    --   "<leader>di",
    --   function()
    --     require("dap").step_into()
    --   end,
    --   desc = "DAP(step into)",
    -- },

    {
      "<leader><F11>",
      function()
        require("dap").step_out()
      end,
      desc = "step out(dap)",
    },
    -- {
    --   "<leader>dO",
    --   function()
    --     require("dap").step_out()
    --   end,
    --   desc = "DAP(step out)",
    -- },

    -- {
    --   "<leader>dl",
    --   function()
    --     require("dap").run_last()
    --   end,
    --   desc = "DAP(run last)",
    -- },
    -- {
    --   "<leader>dT",
    --   function()
    --     require("dap").terminate()
    --   end,
    --   desc = "DAP(terminate)",
    -- },
    --
    -- {
    --   "<Leader>dr",
    --   function()
    --     require("dap").repl.open()
    --   end,
    --   desc = "DAP(REPL open)",
    -- },
    -- {
    --   "<Leader>dw",
    --   function()
    --     require("dap.ui.widgets").hover()
    --   end,
    --   mode = { "n", "v" },
    --   desc = "DAP(widgets)",
    -- },
    -- {
    --   "<Leader>dp",
    --   function()
    --     require("dap.ui.widgets").preview()
    --   end,
    --   mode = { "n", "v" },
    --   desc = "DAP(widgets preview)",
    -- },
    -- {
    --   "<Leader>df",
    --   function()
    --     local widgets = require("dap.ui.widgets")
    --     widgets.centered_float(widgets.frames)
    --   end,
    --   desc = "DAP(frames)",
    -- },
    -- {
    --   "<Leader>ds",
    --   function()
    --     local widgets = require("dap.ui.widgets")
    --     widgets.centered_float(widgets.scopes)
    --   end,
    --   desc = "DAP(scopes)",
    -- },
  },
  ["dap-ui"] = {
    {
      "<F12>",
      function()
        require("dapui").toggle()
      end,
      desc = "toggle ui(dap-ui)",
    },
  },
  ["dap-go"] = {
    {
      "<leader>td",
      function()
        require("dap-go").debug_test()
      end,
      desc = "DAP-GO(Debug test: closest method)",
    },
    {
      "<leader>tD",
      function()
        require("dap-go").debug_last_test()
      end,
      desc = "DAP-GO(Debug test: last method)",
    },
  },
}
