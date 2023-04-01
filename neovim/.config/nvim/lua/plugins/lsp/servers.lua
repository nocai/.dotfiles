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
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        usePlaceholders = false,
        staticcheck = true,
        analyses = {
          unreachable = true,
          unusedparams = true,
        },
      },
    },
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          procMacro = { enable = true },
          cargo = { allFeatures = true },
          -- checkOnSave = {
          --   command = "clippy",
          --   extraArgs = { "--no-deps" },
          -- },
        },
      },
    },
  },
}
