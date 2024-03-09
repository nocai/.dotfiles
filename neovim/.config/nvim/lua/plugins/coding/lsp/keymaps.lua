local M = {}

function M.goto_diagnostic(next, severity)
  local goto_diag = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    goto_diag({ severity = severity })
  end
end

vim.keymap.set("n", ivim.keymaps.Diagnostics, "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", ivim.keymaps.Diagnostic, vim.diagnostic.open_float, { desc = "Diagnostic" })
vim.keymap.set("n", ivim.keymaps.GotoDiagnosticNext, M.goto_diagnostic(true), { desc = "Diagnostic next" })
vim.keymap.set("n", ivim.keymaps.GotoDiagnosticPrev, M.goto_diagnostic(false), { desc = "Diagnostic prev" })
vim.keymap.set("n", ivim.keymaps.GotoDiagnosticErrorNext, M.goto_diagnostic(true, "ERROR"), { desc = "Error next" })
vim.keymap.set("n", ivim.keymaps.GotoDiagnosticErrorPrev, M.goto_diagnostic(false, "ERROR"), { desc = "Error prev" })
vim.keymap.set("n", ivim.keymaps.GotoDiagnosticWarnNext, M.goto_diagnostic(true, "WARN"), { desc = "Warn next" })
vim.keymap.set("n", ivim.keymaps.GotoDiagnosticWarnPrev, M.goto_diagnostic(false, "WARN"), { desc = "Warn prev" })

function M.on_attach(_, buffer)
  vim.keymap.set("n", ivim.keymaps.Hover, vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
  vim.keymap.set(
    { "s", "i" },
    ivim.keymaps.SignatureHelp,
    vim.lsp.buf.signature_help,
    { buffer = buffer, desc = "Signature help" }
  )
  vim.keymap.set(
    "n",
    ivim.keymaps.GotoDefinition,
    "<cmd>Telescope lsp_definitions<cr>",
    { buffer = buffer, desc = "Definition" }
  )
  vim.keymap.set("n", ivim.keymaps.GotoDeclaration, vim.lsp.buf.declaration, { buffer = buffer, desc = "Declaration" })
  vim.keymap.set(
    "n",
    ivim.keymaps.GotoTypeDefinition,
    "<cmd>Telescope lsp_type_definitions<cr>",
    { buffer = buffer, desc = "Type definitions" }
  )
  vim.keymap.set(
    "n",
    ivim.keymaps.GotoReferences,
    "<cmd>Telescope lsp_references theme=get_ivy<cr>",
    { buffer = buffer, desc = "References" }
  )
  vim.keymap.set(
    "n",
    ivim.keymaps.GotoImplementation,
    "<cmd>Telescope lsp_implementations theme=get_ivy<cr>",
    { buffer = buffer, desc = "Implementations" }
  )
  vim.keymap.set(
    "n",
    ivim.keymaps.GotoDocumentSymbols,
    "<cmd>Telescope lsp_document_symbols theme=get_ivy<cr>",
    { buffer = buffer, desc = "Document symbol" }
  )

  vim.keymap.set("n", ivim.keymaps.Rename, vim.lsp.buf.rename, { buffer = buffer, desc = "Rename" })
  vim.keymap.set(
    { "n", "v" },
    ivim.keymaps.CodeActions,
    vim.lsp.buf.code_action,
    { buffer = buffer, desc = "Code actions" }
  )

  -- format by plugin
  -- vim.keymap.set(
  --   "n",
  --   ivim.keymaps.FormatDocument,
  --   vim.lsp.buf.format,
  --   { buffer = buffer, desc = "Format document" }
  -- )

  -- vim.keymap.set("n", "<leader>cr", vim.lsp.codelens.run, { buffer = buffer, desc = "lsp: codelens run" })

  vim.keymap.set(
    "n",
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    { buffer = buffer, desc = "Add workspace folder" }
  )
  vim.keymap.set(
    "n",
    "<leader>wd",
    vim.lsp.buf.remove_workspace_folder,
    { buffer = buffer, desc = "Remove workspace folder" }
  )
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = buffer, desc = "Workspace folder" })
end

return M
