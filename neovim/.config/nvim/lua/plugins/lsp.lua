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
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("config.lazy.util").has("nvim-cmp")
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = function()
          local ensure_installed = { "lua_ls" }
          local Servers = require("plugins.lsp.servers")
          return {
            ensure_installed = vim.list_extend(ensure_installed, vim.tbl_keys(Servers)),
          }
        end,
        dependencies = {
          "williamboman/mason.nvim",
          opts = {
            ensure_installed = { "stylua" },
            ui = { border = "rounded" },
            github = {
              -- download_url_template = ivim.git_proxy("https://github.com/%s/releases/download/%s/%s"),
              download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
            },
          },
          config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
              local p = mr.get_package(tool)
              if not p:is_installed() then
                p:install()
              end
            end
          end,
        },
      },
    },
    config = function()
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
