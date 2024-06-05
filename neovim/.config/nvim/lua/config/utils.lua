_G.ivim.git_proxy = function(url)
  return url
  -- return string.format("https://ghproxy.com/%s", url)
end

_G.ivim.on_very_lazy = function(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

_G.ivim.on_attach = function(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local buffer = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      on_attach(client, buffer)
    end,
  })
end
