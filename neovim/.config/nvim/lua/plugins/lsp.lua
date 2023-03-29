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
    opts = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
    },
  },
  -- inlay hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "LspAttach",
    opts = {},
    enabled = false,
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
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
        },
        config = function(_, opts)
          local Servers = require("plugins.lsp.servers")
          opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, vim.tbl_keys(Servers))
          require("mason-lspconfig").setup(opts)

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

          require("mason-lspconfig").setup_handlers({
            function(server_name)
              local server_opts = vim.tbl_deep_extend("force", {
                capabilities = vim.deepcopy(capabilities),
              }, Servers[server_name] or {})
              require("lspconfig")[server_name].setup(server_opts)
            end,
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
        -- Util.code_lens(client, buffer)

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
