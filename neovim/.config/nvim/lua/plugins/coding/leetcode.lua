return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- configuration goes here
    lang = "golang",
    cn = {
      enabled = true,
      -- translator = false,
    },
    -- storage = {
    --   home = vim.fn.stdpath("data") .. "/leetcode/src",
    --   cache = vim.fn.stdpath("cache") .. "/leetcode/src",
    -- },
    -- @type table<lc.lang, lc.inject>
    injector = {
      -- ["cpp"] = {
      --     before = { "#include <bits/stdc++.h>", "using namespace std;" },
      --     after = "int main() {}",
      -- },
      ["golang"] = {
        before = "package leetcode",
      },
    },
  },
  cmd = { "Leet" },
}
