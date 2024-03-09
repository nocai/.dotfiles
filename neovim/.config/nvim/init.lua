_G.ivim = {
  -- tokyonight
  -- dracula
  -- catppuccin
  -- nightfox
  -- onedark
  -- colorscheme = "catppuccin",
  colorscheme = "tokyonight",
  git_proxy = function(url)
    return url
    -- return string.format("https://ghproxy.com/%s", url)
  end,
  keymaps = {
    GotoDefinition = "gd",
    PeekDefinition = "<leader>gd",

    GotoDeclaration = "gD",
    PeekDeclaration = "<leader>gD",

    GotoTypeDefinition = "gy",
    PeekTypeDefinition = "<leader>gy",

    GotoImplementation = "gI", -- gI -- gi: last insert position
    PeekImplementation = "<leader>gi",

    GotoReferences = "gr",
    PeekReferences = "<leader>gr",

    GotoDocumentSymbols = "gs", -- gs: leap.nvim
    PeekDocumentSymbols = "<leader>gs",

    PeekFunction = "<leader><tab>f",
    PeekClass = "<leader><tab>c",

    Diagnostics = "<leader>X",
    Diagnostic = "<leader>x", -- <leader>d: debug
    GotoDiagnosticPrev = "[x",
    GotoDiagnosticNext = "]x",
    GotoDiagnosticWarnPrev = "[w",
    GotoDiagnosticWarnNext = "]w",
    GotoDiagnosticErrorPrev = "[e",
    GotoDiagnosticErrorNext = "]e",

    Hover = "K",
    SignatureHelp = "<C-K>",
    -- FormatDocument = "gq",

    Rename = "<leader>rn",
    CodeLens = "<leader>cl",
    CodeActions = "<leader>ca",
  },
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

for _, source in ipairs({
  "config.options",
  "config.keymaps",
  "config.lazy",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

if vim.g.vscode then
  require("config.vscode")
else
  require("config.autocmds")
end

if vim.g.neovide then
  require("config.neovide")
end
