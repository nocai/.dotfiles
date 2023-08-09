return {
  "toppair/peek.nvim",
  build = "deno task --quiet build:fast",
  enabled = false,
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
