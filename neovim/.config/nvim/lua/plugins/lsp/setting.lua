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
  virtual_text = {
    -- spacing = 4,
    source = "if_many",
    prefix = "●",
    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
    -- prefix = "icons",
  },
  severity_sort = true,
  float = {
    -- focusable = false,
    border = "rounded",
  },
})
