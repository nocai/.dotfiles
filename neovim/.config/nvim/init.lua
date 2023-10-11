_G.ivim = {
  -- tokyonight
  -- dracula
  -- catppuccin
  -- nightfox
  -- onedark
  -- colorscheme = "catppuccin",
  colorscheme = "tokyonight",
  git_proxy = function(url)
    return string.format("https://ghproxy.com/%s", url)
  end,
  keymaps = {
    GotoDefinition = "gd",
    PeekDefinition = "<leader>gd",

    GotoDeclaration = "gD",
    PeekDeclaration = "<leader>gD",

    GotoTypeDefinition = "gy",
    PeekTypeDefinition = "<leader>gy",

    GotoImplementation = "gi", -- gI -- gi: last insert position
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

    Hover = "K",
    SignatureHelp = "<C-K>",
    FormatDocument = "gq",

    Rename = "<leader>rn",
    CodeActions = "<leader>ca",
    CodeLens = "<leader>cl",
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

if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
  vim.loader.enable()
end

for _, source in ipairs({
  "config.options",
  "config.lazy",
  "config.autocmds",
  "config.keymaps",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

if vim.g.neovide then
  require("config.neovide")
end

if vim.g.vscode then
  require("config.vscode")
end
