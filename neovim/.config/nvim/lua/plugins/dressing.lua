return {
  "stevearc/dressing.nvim",
  enabled = not vim.g.vscode,
  opts = {
    input = {
      win_options = {
        winblend = 0,
      },
    },
    select = {
      -- Priority list of preferred vim.select implementations
      backend = { "telescope" }, -- "telescope", "fzf_lua", "fzf", "builtin", "nui"
      builtin = {
        -- relative = "win",
        win_options = {
          winblend = 0,
        },
        min_height = { 2 },
      },
    },
  },
  init = function()
    vim.ui.select = function(...)
      require("lazy").load({ plugins = "dressing.nvim" })
      return vim.ui.select(...)
    end
    vim.ui.input = function(...)
      require("lazy").load({ plugins = "dressing.nvim" })
      return vim.ui.input(...)
    end
  end,
}
