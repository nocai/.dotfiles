return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = false,
  -- lazy = false,
  keys = {
    {
      "<leader>x",
      function()
        require("trouble").open()
      end,
      desc = "Trouble",
    },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
