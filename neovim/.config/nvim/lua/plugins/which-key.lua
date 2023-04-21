return {
  "folke/which-key.nvim",
  enabled = not vim.g.vscode,
  -- event = "VeryLazy",
  keys = { "<space>" },
  opts = {
    plugins = { spelling = true },
    window = {
      border = "rounded",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    --   wk.register({
    --     ["<leader>t"] = { name = "+test" },
    --
    --     -- ["<leader>d"] = { name = "+dap(debug)" },
    --     -- ["<leader>dt"] = { name = "+dap(debug test)" },
    --
    --     ["<leader>c"] = { name = "+code" },
    --     ["<leader>h"] = { name = "+hunk" },
    --     ["<leader>x"] = { name = "+trouble: todo/fix" },
    --
    --     ["<leader>f"] = { name = "+file/find" },
    --     ["<leader>g"] = { name = "+git" },
    --   })
  end,
}
