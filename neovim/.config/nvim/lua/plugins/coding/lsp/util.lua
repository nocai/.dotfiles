local M = {
  enabled = true,
}
-- toggle
vim.keymap.set("n", [[\d]], function()
  M.toggle_diagnostics()
end, { desc = "Toggle Diagnostics" })

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.document_highlight(client, buffer)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = buffer,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = buffer,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = buffer,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

function M.code_lens(client, buffer)
  if client.server_capabilities.codeLensProvider and client.server_capabilities.codeLensProvider.resolveProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      buffer = buffer,
      callback = vim.lsp.codelens.refresh,
    })
  end
end

function M.toggle_diagnostics()
  M.enabled = not M.enabled
  if M.enabled then
    vim.diagnostic.enable()
    require("lazy.core.util").info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    require("lazy.core.util").warn("Disabled diagnostics", { title = "Diagnostics" })
  end
end

return M
