local M = {}

function M._diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set("n", ivim.lsp_keys.Diagnostic, vim.diagnostic.open_float, { desc = "lsp: diagnostic float" })
vim.keymap.set("n", ivim.lsp_keys.DiagnosticNext, M._diagnostic_goto(true), { desc = "lsp: diagnostic next" })
vim.keymap.set("n", ivim.lsp_keys.DiagnosticPrev, M._diagnostic_goto(false), { desc = "lsp: diagnostic prev" })
vim.keymap.set("n", "]e", M._diagnostic_goto(true, "ERROR"), { desc = "lsp: error next" })
vim.keymap.set("n", "[e", M._diagnostic_goto(false, "ERROR"), { desc = "lsp: error prev" })
vim.keymap.set("n", "]w", M._diagnostic_goto(true, "WARN"), { desc = "lsp: warn next" })
vim.keymap.set("n", "[w", M._diagnostic_goto(false, "WARN"), { desc = "lsp: warn prev" })

function M.on_attach(_, buffer)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "lsp: hover" })
  vim.keymap.set({ "i", "s" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = buffer, desc = "lsp: signature help" })
  vim.keymap.set(
    "n",
    ivim.lsp_keys.GotoDefinition,
    "<cmd>Telescope lsp_definitions<cr>",
    { buffer = buffer, desc = "lsp: definition" }
  )
  vim.keymap.set(
    "n",
    ivim.lsp_keys.PeekDefinition,
    vim.lsp.buf.declaration,
    { buffer = buffer, desc = "lsp: declaration" }
  )
  vim.keymap.set(
    "n",
    ivim.lsp_keys.GotoTypeDefinition,
    "<cmd>Telescope lsp_type_definitions<cr>",
    { buffer = buffer, desc = "lsp: type definitions" }
  )
  vim.keymap.set(
    "n",
    ivim.lsp_keys.GotoReferences,
    "<cmd>Telescope lsp_references theme=get_ivy<cr>",
    { buffer = buffer, desc = "lsp: references" }
  )
  vim.keymap.set(
    "n",
    ivim.lsp_keys.GotoImplementation,
    "<cmd>Telescope lsp_implementations theme=get_ivy<cr>",
    { buffer = buffer, desc = "lsp: implementations" }
  )
  vim.keymap.set(
    "n",
    ivim.lsp_keys.GotoSymbols,
    "<cmd>Telescope lsp_document_symbols theme=get_ivy<cr>",
    { buffer = buffer, desc = "lsp:document symbol" }
  )
  vim.keymap.set("n", ivim.lsp_keys.Rename, vim.lsp.buf.rename, { buffer = buffer, desc = "lsp: rename" })
  vim.keymap.set("n", ivim.lsp_keys.FormatDocument, function()
    require("plugins.lsp.format").format(buffer)
  end, { buffer = buffer, desc = "lsp: format" })

  vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { buffer = buffer, desc = "lsp: codelens run" })

  vim.keymap.set(
    "n",
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    { buffer = buffer, desc = "add workspace folder" }
  )
  vim.keymap.set(
    "n",
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { buffer = buffer, desc = "remove workspace folder" }
  )
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = buffer, desc = "workspace folder" })

  vim.keymap.set(
    { "n", "v" },
    ivim.lsp_keys.CodeActions,
    vim.lsp.buf.code_action,
    { buffer = buffer, desc = "lsp: code actions" }
  )
end

return M