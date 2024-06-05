_G.ivim = {
  keymaps = {
    GotoDefinition = "gd",
    PeekDefinition = "<leader>gd",

    GotoDeclaration = "gD",
    PeekDeclaration = "<leader>gD",

    Rename = "grn",
    CodeLens = "grl",
    CodeActions = "gra",

    GotoReferences = "grr",
    -- PeekReferences = "<leader>gr",

    GotoTypeDefinition = "grt",
    PeekTypeDefinition = "<leader>grt",

    GotoImplementation = "gri",
    PeekImplementation = "<leader>gri",

    GotoDocumentSymbols = "grs",
    -- PeekDocumentSymbols = "<leader>gs",

    -- PeekFunction = "<leader><tab>f",
    -- PeekClass = "<leader><tab>c",

    SignatureHelp = "<C-K>",
    -- FormatDocument = "gq",
  },
  -- icons used by other plugins
  icons = {
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    kinds = {
      Array = " ",
      Boolean = " ",
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
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

require("config.utils")

require("config.options")
require("config.keymaps")

if vim.g.vscode then
  require("config.vscode")
else
  require("config.autocmds")
end

if vim.g.neovide then
  require("config.neovide")
end
