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
          ensure_installed = { "lua_ls" },
        },
        config = function(_, opts)
          local Servers = require("plugins.lsp.servers")
          require("mason-lspconfig").setup({
            ensure_installed = vim.list_extend(opts.ensure_installed, vim.tbl_keys(Servers)),
            automatic_installation = true,
          })

          -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
          require("mason-lspconfig").setup_handlers({
            function(server_name)
              local settings = Servers[server_name] or {}
              settings.capabilities = capabilities
              require("lspconfig")[server_name].setup(settings)
            end,
          })
        end,
        dependencies = {
          {
            "hrsh7th/cmp-nvim-lsp",
            cond = function()
              return require("config.lazy.util").has("nvim-cmp")
            end,
          },
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

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
}