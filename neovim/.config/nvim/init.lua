_G.ivim = {
  lsp_keys = {
    GotoDefinition = "gd",
    PeekDefinition = "<leader>gd",

    GotoDeclaration = "gD",
    PeekDeclaration = "<leader>gD",

    GotoTypeDefinition = "gy",
    PeekTypeDefinition = "<leader>gy",

    GotoImplementation = "gI", -- gi: last insert position
    PeekImplementation = "<leader>gi",

    GotoReferences = "gr",
    PeekReferences = "<leader>gr",

    GotoDocumentSymbols = "gs", -- gs: leap.nvim
    PeekDocumentSymbols = "<leader>gs",

    PeekFunction = "<leader>pf",
    PeekClass = "<leader>pc",

    Diagnostic = "<leader>d", -- <leader>d: debug
    DiagnosticPrev = "[d",
    DiagnosticNext = "]d",
    DiagnosticWarnPrev = "[w",
    DiagnosticWarnNext = "]w",
    DiagnosticErrorPrev = "[e",
    DiagnosticErrorNext = "]e",

    Rename = "<leader>rn",
    CodeActions = "<leader>ca",
    CodeLens = "<leader>cl",
    Hover = "K",
    SignatureHelp = "<C-K>",
    FormatDocument = "gq",
  },
  is_mac = jit.os == "OSX",
  git_proxy = function(url)
    return string.format("https://ghproxy.com/%s", url)
  end,
  -- icons used by other plugins
  icons = {
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    kinds = {
      Array = " ",
      Boolean = " ",
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Copilot = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Namespace = " ",
      Null = "ﳠ ",
      Number = " ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    },
  },
}

-- bootstrap lazy.nvim
require("config.lazy")
if not vim.g.vscode then
  vim.cmd.colorscheme("tokyonight")
  -- vim.cmd.colorscheme("dracula")
  -- vim.cmd.colorscheme("catppuccin")
end
