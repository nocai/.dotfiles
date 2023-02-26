if vim.g.vscode then
  return {}
end

return {
  {
    "folke/neodev.nvim",
    ft = "lua",
    opts = {
      experimental = { pathStrict = true },
      library = { plugins = { "lazy" }, types = true },
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
        dependencies = {
          "williamboman/mason.nvim",
          opts = {
            ui = { border = "rounded" },
            github = {
              download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
            },
          },
        },
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("config.lazy.util").has("nvim-cmp")
        end,
      },
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local Servers = require("plugins.lsp.servers")
      for server, opts in pairs(Servers) do
        opts.capabilities = capabilities
        require("lspconfig")[server].setup(opts)
      end

      local Util = require("plugins.lsp.util")
      Util.on_attach(function(client, buffer)
        require("plugins.lsp.setting")

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
  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
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
}
