if vim.g.vscode then
  return {}
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {
          window = {
            blend = 0, -- &winblend for the window
          },
        },
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

          local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
          if ok then
            capabilities = cmp_nvim_lsp.default_capabilities()
          end

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

        local Keymaps = require("plugins.lsp.keymaps")
        Keymaps.on_attach(client, buffer)

        local Format = require("plugins.lsp.format")
        Format.on_attach(client, buffer)

        local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
        if inlay_hint then
          if client.server_capabilities.inlayHintProvider then
            inlay_hint.enable(buffer, true)
          end
        end
      end)
    end,
  },
  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.jq,
          nls.builtins.formatting.yamlfmt,
          -- nls.builtins.formatting.markdownlint,

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
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   enabled = false,
  --   event = "LspAttach",
  --   opts = {
  --     symbols = {
  --       Array = { icon = " " },
  --       Boolean = { icon = " " },
  --       Class = { icon = " " },
  --       Color = { icon = " " },
  --       Constant = { icon = " " },
  --       Constructor = { icon = " " },
  --       Copilot = { icon = " " },
  --       Enum = { icon = " " },
  --       EnumMember = { icon = " " },
  --       Event = { icon = " " },
  --       Field = { icon = " " },
  --       File = { icon = " " },
  --       Folder = { icon = " " },
  --       Function = { icon = " " },
  --       Interface = { icon = " " },
  --       Key = { icon = " " },
  --       Keyword = { icon = " " },
  --       Method = { icon = " " },
  --       Module = { icon = " " },
  --       Namespace = { icon = " " },
  --       Null = { icon = "ﳠ " },
  --       Number = { icon = " " },
  --       Object = { icon = " " },
  --       Operator = { icon = " " },
  --       Package = { icon = " " },
  --       Property = { icon = " " },
  --       Reference = { icon = " " },
  --       Snippet = { icon = " " },
  --       String = { icon = " " },
  --       Struct = { icon = " " },
  --       Text = { icon = " " },
  --       TypeParameter = { icon = " " },
  --       Unit = { icon = " " },
  --       Value = { icon = " " },
  --       Variable = { icon = " " },
  --     },
  --   },
  -- },
}
