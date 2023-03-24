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
    "simrat39/rust-tools.nvim",
    ft = "rust",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "j-hui/fidget.nvim",
        opts = {
          window = {
            blend = 0, -- &winblend for the window
          },
        },
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("config.lazy.util").has("nvim-cmp")
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { "lua_ls" },
          automatic_installation = true,
        },
        config = function(_, opts)
          local Servers = require("plugins.lsp.servers")
          opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, vim.tbl_keys(Servers))
          require("mason-lspconfig").setup(opts)
          require("mason-lspconfig").setup_handlers({
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler (optional)
              require("lspconfig")[server_name].setup({})
            end,
            -- -- Next, you can provide a dedicated handler for specific servers.
            -- -- For example, a handler override for the `rust_analyzer`:
            -- ["rust_analyzer"] = function ()
            --     require("rust-tools").setup {}
            -- end
          })
        end,
        dependencies = {
          {
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
    },
    config = function()
      local Util = require("plugins.lsp.util")
      Util.on_attach(function(client, buffer)
        require("plugins.lsp.setting")

        -- Util.document_highlight(client, buffer)
        Util.code_lens(client, buffer)

        -- setup formatting and keymaps
        local Format = require("plugins.lsp.format")
        Format.on_attach(client, buffer)

        local Keymaps = require("plugins.lsp.keymaps")
        Keymaps.on_attach(client, buffer)
      end)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        },
      }

      local Servers = require("plugins.lsp.servers")
      for server_name, settings in pairs(Servers) do
        settings.capabilities = capabilities
        require("lspconfig")[server_name].setup(settings)
      end
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
          nls.builtins.formatting.yamlfmt,
          nls.builtins.formatting.markdownlint,

          nls.builtins.diagnostics.golangci_lint,
          -- nls.builtins.diagnostics.markdownlint,
          -- nls.builtins.diagnostics.yamllint,
        },
      }
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure()
    end,
  },
}
