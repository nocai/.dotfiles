return {
  -- better vim.ui
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
      backend = { "builtin" }, -- "telescope", "fzf_lua", "fzf", "builtin", "nui"
      builtin = {
        relative = "win",
        win_options = {
          winblend = 0,
        },
        min_height = { 2 },
      },
    },
  },
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("lazy").load({ plugins = "dressing.nvim" })
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require("lazy").load({ plugins = "dressing.nvim" })
      return vim.ui.input(...)
    end
  end,
}
