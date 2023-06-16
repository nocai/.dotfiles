return {
  {
    "rebelot/heirline.nvim",
    -- event = "VeryLazy",
    event = "BufEnter",
    enabled = false,
    config = function()
      require("plugins.heirline.colors")

      local Align = { provider = "%=" }
      local Space = { provider = " " }

      local ViMode = require("plugins.heirline.vimode")
      local FileName = require("plugins.heirline.file")
      local Diagnostics = require("plugins.heirline.diagnostics")
      local Git = require("plugins.heirline.git")

      local Ruler = {
        -- %l = current line number
        -- %L = number of lines in the buffer
        -- %c = column number
        -- %P = percentage through file of displayed window
        provider = "%7(%l/%3L%):%2c %P",
      }
      local ScrollBar = {
        static = {
          sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
          -- sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
        },
        provider = function(self)
          local curr_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_line_count(0)
          local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
          return string.rep(self.sbar[i], 2)
        end,
        hl = { fg = "blue", bg = "bright_bg" },
      }
      -- ViMode = utils.surround({ "", "" }, "#000000", { ViMode })
      local StatusLine = {
        { ViMode },
        { Git },
        { Diagnostics },
        { FileName },
        { Align },
        Ruler,
        Space,
        ScrollBar,
        hl = { bg = "statusline" },
      }
      require("heirline").setup({
        statusline = StatusLine,
      })
    end,
  },
}
