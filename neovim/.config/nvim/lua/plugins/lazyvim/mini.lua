return {
  -- {
  -- 	"kylechui/nvim-surround",
  -- 	event = { "VeryLazy" },
  -- 	config = function()
  -- 		require("nvim-surround").setup()
  -- 	end,
  -- },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding

        -- 与leap.nvim冲突。不用
        -- Use `''` (empty string) to disable one.
        find = "", -- 'sf', -- Find surrounding (to the right)
        find_left = "", -- 'sF', -- Find surrounding (to the left)
        highlight = "", -- 'sh', -- Highlight surrounding
        update_n_lines = "", -- 'sn', -- Update `n_lines`
        suffix_last = "", -- 'l', -- Suffix to search with "prev" method
        suffix_next = "", -- 'n', -- Suffix to search with "next" method
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    enabled = not vim.g.vscode,
  },
  {
    "echasnovski/mini.pairs",
    enabled = not vim.g.vscode,
  },
}
