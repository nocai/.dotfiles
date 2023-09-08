return {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim", "redis", "nvim", "jit" } },
        workspace = {
          checkThirdParty = false,
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  gopls = {
    cmd = { "gopls", "--remote=auto" },
    init_options = {
      usePlaceholders = true,
      staticcheck = true,
      analyses = {
        unreachable = true,
        unusedparams = true,
      },
      -- hints = {
      --   assignVariableTypes = true,
      --   compositeLiteralFields = true,
      --   compositeLiteralTypes = true,
      --   constantValues = true,
      --   functionTypeParameters = true,
      --   -- parameterNames = true,
      --   rangeVariableTypes = true,
      -- },
    },
  },
  rust_analyzer = {
    -- root_dir = function(fname)
    --   local util = require("lspconfig.util")
    --   return util.root_pattern(".git")(fname)
    -- end,
    settings = {
      ["rust-analyzer"] = {
        -- diagnostics = {
        --   enable = true,
        --   disabled = { "unresolved-proc-macro" },
        --   enableExperimental = true,
        -- },
        -- checkOnSave = {
        --   command = "clippy",
        --   extraArgs = { "--no-deps" },
        -- },
        -- imports = {
        --   granularity = {
        --     group = "module",
        --   },
        --   prefix = "self",
        -- },
        -- cargo = {
        --   allFeatures = true,
        --   buildScripts = {
        --     enable = true,
        --   },
        -- },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}
