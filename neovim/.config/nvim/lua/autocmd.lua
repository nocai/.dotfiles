local autocmd = vim.api.nvim_create_autocmd

-- Open a file from its last left off position
autocmd("BufReadPost", {
  callback = function()
    if not vim.fn.expand("%:p"):match(".git") and vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
      -- vim.cmd("normal zz")
    end
  end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
