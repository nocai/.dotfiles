return {
  {
    "tweekmonster/startuptime.vim",
    cmd = { "StartupTime" },
    enabled = not vim.g.vscode,
  },
  {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-\>]] },
    enabled = not vim.g.vscode,
    opts = {
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
      highlights = {
        FloatBorder = {
          link = "FloatBorder",
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = not vim.g.vscode,
    cmd = "WhichKey",
    opts = {
      plugins = { spelling = true },
      window = {
        border = "rounded",
      },
    },
    -- config = function(_, opts)
    -- 	local wk = require("which-key")
    -- 	wk.setup(opts)
    -- 	local keymaps = {
    -- 		mode = { "n", "v" },
    -- 		["g"] = { name = "+goto" },
    -- 		["gz"] = { name = "+surround" },
    -- 		["]"] = { name = "+next" },
    -- 		["["] = { name = "+prev" },
    -- 		["<leader><tab>"] = { name = "+tabs" },
    -- 		["<leader>b"] = { name = "+buffer" },
    -- 		["<leader>c"] = { name = "+code" },
    -- 		["<leader>f"] = { name = "+file/find" },
    -- 		["<leader>g"] = { name = "+git" },
    -- 		["<leader>gh"] = { name = "+hunks" },
    -- 		["<leader>q"] = { name = "+quit/session" },
    -- 		["<leader>s"] = { name = "+search" },
    -- 		["<leader>u"] = { name = "+ui" },
    -- 		["<leader>w"] = { name = "+windows" },
    -- 		["<leader>x"] = { name = "+diagnostics/quickfix" },
    -- 	}
    -- 	if Util.has("noice.nvim") then
    -- 		keymaps["<leader>sn"] = { name = "+noice" }
    -- 	end
    -- 	wk.register(keymaps)
    -- end,
  },
  {
    "kylechui/nvim-surround",
    event = { "VeryLazy" },
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
}
