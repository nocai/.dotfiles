local adapters_gen = {}

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
    },
    opts = function()
      local adapters = {}
      for _, gen in ipairs(adapters_gen) do
        table.insert(adapters, gen())
      end
      return { adapters = adapters }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  },
  -- 下面为neotest adapter的配置
  -- 注意懒加载问题
  {
    "nvim-neotest/neotest-go",
    ft = "go",
    config = function()
      table.insert(adapters_gen, function()
        return require("neotest-go")
      end)
    end,
  },
  {
    "rouge8/neotest-rust",
    ft = "rust",
    config = function()
      table.insert(adapters_gen, function()
        return require("neotest-rust")({
          args = { "--no-capture" },
        })
      end)
    end,
  },
}
