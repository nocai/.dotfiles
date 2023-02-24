local M = {}

function M._diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

function M.on_attach(_, buffer)
  local opts = { buffer = buffer }

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set({ "i", "s" }, "<C-k>", vim.lsp.buf.signature_help, opts)

  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", ivim.lsp_keys.GotoDefinition, "<cmd>Telescope lsp_definitions<cr>", opts)
  vim.keymap.set("n", ivim.lsp_keys.PeekDefinition, vim.lsp.buf.declaration, opts)

  -- vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", ivim.lsp_keys.GotoTypeDefinition, "<cmd>Telescope lsp_type_definitions<cr>", opts)

  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  -- vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, opts)
  vim.keymap.set("n", ivim.lsp_keys.GotoImplementation, "<cmd>Telescope lsp_implementations theme=get_ivy<cr>", opts)
  vim.keymap.set("n", ivim.lsp_keys.GotoSymbols, "<cmd>Telescope lsp_document_symbols theme=get_ivy<cr>", opts)
  vim.keymap.set("n", ivim.lsp_keys.GotoReferences, "<cmd>Telescope lsp_references theme=get_ivy<cr>", opts)

  vim.keymap.set("n", ivim.lsp_keys.Diagnostic, vim.diagnostic.open_float, opts)
  vim.keymap.set("n", ivim.lsp_keys.DiagnosticNext, M._diagnostic_goto(true), opts)
  vim.keymap.set("n", ivim.lsp_keys.DiagnosticPrev, M._diagnostic_goto(false), opts)
  vim.keymap.set("n", "]e", M._diagnostic_goto(true, "ERROR"), opts)
  vim.keymap.set("n", "[e", M._diagnostic_goto(false, "ERROR"), opts)
  vim.keymap.set("n", "]w", M._diagnostic_goto(true, "WARN"), opts)
  vim.keymap.set("n", "[w", M._diagnostic_goto(false, "WARN"), opts)

  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

  vim.keymap.set("n", "<leader>cf", function()
    require("plugins.lsp.format").format(buffer)
  end, opts)

  vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
end

return M
