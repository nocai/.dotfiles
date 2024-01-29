return {
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter" },
    opts = {
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "<", close = ">" },
      },
    },
  },
}
