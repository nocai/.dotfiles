if vim.g.vscode then
  return {}
end

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

return {
  {
    "folke/neodev.nvim",
    ft = "lua",
    opts = { experimental = { pathStrict = true } },
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
      github = {
        download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { "lua_ls", "rust_analyzer" },
        },
        config = function(_, opts)
          require("mason-lspconfig").setup(opts)

          local Servers = require("plugins.lsp.servers")
          local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
          require("mason-lspconfig").setup_handlers({
            function(server_name) -- default handler (optional)
              local opt = Servers[server_name] or {}
              opt.capabilities = capabilities
              require("lspconfig")[server_name].setup(opt)
            end,
            -- Next, you can provide targeted overrides for specific servers.
            -- ["rust_analyzer"] = function()
            -- 	require("rust-tools").setup {}
            -- end,
          })
        end,
      },
      -- formatters
      {
        "jose-elias-alvarez/null-ls.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        -- dependencies = { "mason.nvim" },
        opts = function()
          local nls = require("null-ls")
          return {
            sources = {
              nls.builtins.formatting.stylua,
              nls.builtins.formatting.jq,
              -- nls.builtins.formatting.yamlfmt,
              -- nls.builtins.formatting.markdownlint,

              nls.builtins.diagnostics.golangci_lint,
              -- nls.builtins.diagnostics.markdownlint,
              -- nls.builtins.diagnostics.yamllint,
            },
          }
        end,
      },
    },
    config = function()
      local Util = require("plugins.lsp.util")

      Util.on_attach(function(client, buffer)
        Util.document_highlight(client, buffer)
        Util.code_lens(client, buffer)

        -- setup formatting and keymaps
        local Format = require("plugins.lsp.format")
        Format.on_attach(client, buffer)

        local Keymaps = require("plugins.lsp.keymaps")
        Keymaps.on_attach(client, buffer)
      end)
    end,
  },
}
