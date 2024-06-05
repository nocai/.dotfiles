return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local version = vim.version().minor
    local function stbufnr()
      return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
    end
    local function lsp()
      if rawget(vim, "lsp") and version >= 10 then
        for _, client in ipairs(vim.lsp.get_clients()) do
          if client.attached_buffers[stbufnr()] then
            return (vim.o.columns > 100 and "   LSP ~ " .. client.name .. " ") or "   LSP "
          end
        end
      end
      return ""
    end
    return {
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_x = { lsp, "encoding", "fileformat", "filetype" },
      },
    }
  end,
}
