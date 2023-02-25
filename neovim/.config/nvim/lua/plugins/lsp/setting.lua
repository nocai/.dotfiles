vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  silent = true,
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  silent = true,
  border = "rounded",
})

-- diagnostics
for name, icon in pairs(ivim.icons.diagnostics) do
  name = string.format("DiagnosticSign%s", name)
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
  float = {
    focusable = false,
    border = "rounded",
  },
})
