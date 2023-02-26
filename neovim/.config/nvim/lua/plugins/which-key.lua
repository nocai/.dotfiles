return {
  "folke/which-key.nvim",
  enabled = not vim.g.vscode,
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    window = {
      border = "rounded",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.register({
      ["g"] = { name = "+goto" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },

      ["<leader>t"] = { name = "+test" },

      ["<leader>d"] = { name = "+dap(debug)" },
      ["<leader>dt"] = { name = "+dap(debug test)" },

      ["<leader>c"] = { name = "+code" },
      ["<leader>h"] = { name = "+hunk" },
      ["<leader>x"] = { name = "+trouble: todo/fix" },

      ["<leader>s"] = { name = "+search" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
    })
  end,
}
