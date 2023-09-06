return {
  "akinsho/toggleterm.nvim",
  enabled = not vim.g.vscode,
  -- keys = {
  --   { [[<C-_>]], [[<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>]],
  --     mode = { "n", "i", "t", "x" }, desc = "Open terminal horizontal",
  --   },
  --   {
  --     [[<C-\>]], [[<Cmd>execute v:count . "ToggleTerm direction=float"<CR>]],
  --     mode = { "n", "i", "t", "x" }, desc = "Open terminal vertical",
  --   },
  -- },
  keys = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "rounded",
      },
      hidden = true,
      on_open = function(term)
        vim.keymap.del({ "t" }, "<Esc>")
      end,
      on_close = function(term)
        vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
      end,
    })

    return {
      { [[<C-\>]] },
      {
        "<leader>G",
        function()
          lazygit:toggle()
        end,
        desc = "Lazygit",
      },
    }
  end,
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    open_mapping = [[<C-\>]],
    auto_scroll = false,
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    highlights = {
      FloatBorder = {
        link = "FloatBorder",
      },
    },
  },
}
