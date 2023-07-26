return {
  "toppair/peek.nvim",
  build = "deno task --quiet build:fast",
  enabled = not vim.g.vscode,
  keys = {
    {
      "<leader>pp",
      function()
        local peek = require("peek")
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end,
      desc = "Peek markdown",
    },
  },
  opts = {},
}
