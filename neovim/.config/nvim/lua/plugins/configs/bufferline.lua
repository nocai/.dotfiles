vim.opt.termguicolors = true
require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
    indicator = {
      icon = '⏽',
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center",
        separator = true,
      },
    },
    always_show_bufferline = false,
  }
})
