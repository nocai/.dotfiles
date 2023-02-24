return {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim", "redis", "nvim", "jit" } },
        workspace = {
          checkThirdParty = false,
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
      completeUnimported = true,
      analyses = {
        unreachable = true,
        unusedparams = true,
      },
      staticcheck = true,
    },
    settings = {
      gopls = {
        codelenses = {
          -- generate = true, -- Don't show the `go generate` lens.
          -- gc_details = false, -- Show a code lens toggling the display of gc's choices.
          tidy = true,
          test = true,
          upgrade_dependency = true,
          -- vendor = true,
        },
      },
    },
  },
}
