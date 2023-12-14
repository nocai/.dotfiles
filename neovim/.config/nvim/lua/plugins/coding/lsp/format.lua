local M = {}

M.autoformat = true

vim.keymap.set("n", [[\f]], function() require("plugins.lsp.format").toggle() end, { desc = "Toggle format on Save" })

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.autoformat = true
  else
    M.autoformat = not M.autoformat
  end

  local Util = require("lazy.core.util")
  if M.autoformat then
    Util.info("Enabled format on save", { title = "Format" })
  else
    Util.warn("Disabled format on save", { title = "Format" })
  end
end

function M.on_attach(client, buffer)
  -- dont format if client disabled it
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buffer, {}),
      buffer = buffer,
      callback = function()
        if M.autoformat then
          M.format(buffer)
        end
      end,
    })
  end
end

function M.format(buffer)
  if vim.b.autoformat == false then
    return
  end
  local ft = vim.bo[buffer].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format({
    bufnr = buffer,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  })
end

return M
