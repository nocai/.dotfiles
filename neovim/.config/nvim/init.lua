_G.ivim = {
  lsp_keys = {
    Explorer = "<leader><space>",
    GotoDefinition = "gd",
    PeekDefinition = "gD",
    GotoTypeDefinition = "gy",
    PeekTypeDefinition = "gY",
    GotoImplementation = "gI",
    PeekImplementation = "<leader>gI",
    GotoReferences = "<leader>gr",
    GotoSymbols = "<leader>gs",
    CodeActions = "<leader>ca",
    FormatDocument = "<leader>cf",
    Rename = "<leader>cr",
    Diagnostic = "<leader>d",
    DiagnosticPrev = "[d",
    DiagnosticNext = "]d",
  },
  is_vscode = vim.g.vscode == 1,
  git_proxy = function(url)
    if jit.os == "OSX" then
      return url
    end
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

-- bootstrap lazy.nvim
require("config.lazy")
vim.cmd.colorscheme("tokyonight")
