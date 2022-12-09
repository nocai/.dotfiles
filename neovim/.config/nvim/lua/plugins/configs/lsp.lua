-- vim.lsp.set_log_level("debug")

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", nvim.diagnostics.icons.error)
lspSymbol("Info", nvim.diagnostics.icons.info)
lspSymbol("Hint", nvim.diagnostics.icons.hint)
lspSymbol("Warn", nvim.diagnostics.icons.warning)

vim.diagnostic.config({
  -- update_in_insert = true, -- default: false
  severity_sort = true,
  float = {
    focusable = false,
    border = nvim.window.border,
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  silent = true,
  border = nvim.window.border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  silent = true,
  border = nvim.window.border,
})

vim.notify = function(msg, log_level)
  if msg:match("exit code") then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if present then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

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

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set({ "i", "s" }, "<C-k>", vim.lsp.buf.signature_help, opts)

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, opts)

  vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<Leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  -- vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<Leader>rn", function()
    require("core.renamer").open()
  end, opts)

  vim.keymap.set("n", "gq", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  -- vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)

  -- print(vim.inspect(client.server_capabilities))
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client.server_capabilities.codeLensProvider and client.server_capabilities.codeLensProvider.resolveProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
    vim.keymap.set("n", "<Leader>cr", vim.lsp.codelens.run, opts)
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  -- vim.api.nvim_create_autocmd("CursorHold", {
  -- 	buffer = bufnr,
  -- 	callback = function()
  -- 		vim.diagnostic.open_float(nil, {
  -- 			focusable = false,
  -- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  -- 			border = "rounded",
  -- 			source = "always",
  -- 			prefix = " ",
  -- 			scope = "cursor",
  -- 		})
  -- 	end,
  -- })
end

local M = {
  capabilities = capabilities,
  on_attach = on_attach,
}

function M.lsp()
  local lspconfig = require("lspconfig")

  local servers = { "pyright", "tsserver", "denols" }
  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  -- golang
  lspconfig["gopls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,

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
  })

  -- c
  lspconfig["clangd"].setup({
    on_attach = on_attach,
    capabilities = capabilities,

    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    single_file_support = true,
  })

  -- rust
  lspconfig["rust_analyzer"].setup({
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
        -- inlayHints = {
        -- 	typeHints = {
        -- 		enable = true,
        -- 	},
        -- 	bindingModeHints = {
        -- 		enable = true,
        -- 	},
        -- },
      },
    },
  })

  -- lua
  lspconfig["sumneko_lua"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"lua"},

    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        diagnostics = { enable = true, globals = { "vim", "redis", "nvim", "jit" } },
        workspace = {
          -- library = vim.api.nvim_get_runtime_file("", true),

          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },
  })
end

function M.mason()
  require("mason").setup({
    ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim
    ui = { border = "rounded" },
    github = {
      download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
    },
  })
end

function M.null_ls()
  local ls = require("null-ls")
  ls.setup({
    on_attach = on_attach,
    sources = {
      -- ls.builtins.formatting.stylua,
      -- ls.builtins.formatting.prettier,
      ls.builtins.formatting.jq,
      ls.builtins.formatting.yamlfmt,
      ls.builtins.formatting.markdownlint,

      ls.builtins.diagnostics.golangci_lint,
      ls.builtins.diagnostics.markdownlint,
      ls.builtins.diagnostics.yamllint,
    },
  })
end

function M.nvim_navic()
  local icons = {}
  for key, value in pairs(require("core.lspkind_icon").codicon) do
    icons[key] = value .. ' '
  end
  require("nvim-navic").setup({
    icons = icons,
    highlight = true,
  })
end

function M.symbols_outline()
  local icons = require("core.lspkind_icon").codicon
  require("symbols-outline").setup({
    symbols = {
      File = { icon = icons["File"], hl = "NavicIconsFile" },
      Module = { icon = icons["Module"], hl = "NavicIconsModule" },
      Namespace = { icon = icons["Namespace"], hl = "NavicIconsNamespace" },
      Package = { icon = icons["Package"], hl = "NavicIconsModule" },
      Class = { icon = icons["Class"], hl = "NavicIconsClass" },
      Method = { icon = icons["Method"], hl = "NavicIconsMethod" },
      Property = { icon = icons["Property"], hl = "NavicIconsProperty" },
      Field = { icon = icons["Field"], hl = "NavicIconsField" },
      Constructor = { icon = icons["Constructor"], hl = "NavicIconsConstructor" },
      Enum = { icon = icons["Enum"], hl = "NavicIconsEnum" },
      Interface = { icon = icons["Interface"], hl = "NavicIconsInterface" },
      Function = { icon = icons["Function"], hl = "NavicIconsFunction" },
      Variable = { icon = icons["Variable"], hl = "NavicIconsVariable" },
      Constant = { icon = icons["Constant"], hl = "NavicIconsConstant" },
      String = { icon = icons["String"], hl = "NavicIconsString" },
      Number = { icon = icons["Number"], hl = "NavicIconsNumber" },
      Boolean = { icon = icons["Boolean"], hl = "NavicIconsBoolean" },
      Array = { icon = icons["Array"], hl = "NavicIconsConstant" },
      Object = { icon = icons["Object"], hl = "NavicIconsObject" },
      Key = { icon = icons["Key"], hl = "NavicIconsKey" },
      Null = { icon = icons["Key"], hl = "NavicIconsKey" },
      EnumMember = { icon = icons["EnumMember"], hl = "NavicIconsEnumMember" },
      Struct = { icon = icons["Struct"], hl = "NavicIconsStruct" },
      Event = { icon = icons["Event"], hl = "NavicIconsEvent" },
      Operator = { icon = icons["Operator"], hl = "NavicIconsOperator" },
      TypeParameter = { icon = icons["TypeParameter"], hl = "NavicIconsParameter" }
    }
  })
end

return M
