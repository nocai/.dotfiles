if vim.g.vscode then
  return {}
end

ivim.on_very_lazy(function()
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
    vim.fn.sign_define(name, { text = icon, texthl = name })
  end

  vim.diagnostic.config({
    severity_sort = true,
    float = {
      border = "rounded",
    },
  })
end)

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
          local Servers = require("plugins.coding.lsp.servers")
          opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, vim.tbl_keys(Servers))
          require("mason-lspconfig").setup(opts)

          local capabilities = vim.lsp.protocol.make_client_capabilities()
          local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
          if ok then
            capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
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
                download_url_template = ivim.git_proxy("https://github.com/%s/releases/download/%s/%s"),
                -- download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
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
      ivim.on_attach(function(client, buffer)
        vim.lsp.inlay_hint.enable(true, { buffer })

        require("plugins.coding.lsp.keymaps").on_attach(client, buffer)

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = buffer,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = buffer,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
            end,
          })
        end
      end)
    end,
  },
  {
    "RRethy/vim-illuminate",
    enable = false,
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        filetypes_denylist = { "NvimTree" },
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "gO", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = function()
      local icons = {}
      for kind, icon in pairs(ivim.icons.kinds) do
        icons[kind] = { icon = icon }
      end
      return {
        symbols = { icons = icons },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        -- javascript = { { "prettierd", "prettier" } },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
