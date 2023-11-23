local keymap = vim.keymap

keymap.set(
  "n",
  "<leader>e",
  "<Cmd>lua require('vscode-neovim').action('workbench.files.action.showActiveFileInExplorer')<CR>"
)
keymap.set("n", "<leader><space>", "<Cmd>lua require('vscode-neovim').action('workbench.action.quickOpen')<CR>")

keymap.set(
  { "n", "x" },
  ivim.keymaps.GotoReferences,
  "<Cmd>lua require('vscode-neovim').action('editor.action.referenceSearch.trigger')<CR>"
)
keymap.set({ "n" }, ivim.keymaps.Rename, "<Cmd>lua require('vscode-neovim').action('editor.action.rename')<CR>")
keymap.set(
  { "n" },
  ivim.keymaps.CodeLens,
  "<Cmd>lua require('vscode-neovim').action('codelens.showLensesInCurrentLine')<CR>"
)
keymap.set(
  { "n", "x" },
  ivim.keymaps.CodeActions,
  "<Cmd>lua require('vscode-neovim').action('editor.action.quickFix')<CR>"
)

keymap.set(
  { "n", "x" },
  ivim.keymaps.GotoTypeDefinition,
  "<Cmd>lua require('vscode-neovim').action('editor.action.goToTypeDefinition')<CR>"
)
keymap.set(
  { "n", "x" },
  ivim.keymaps.PeekTypeDefinition,
  "<Cmd>lua require('vscode-neovim').action('editor.action.peekTypeDefinition')<CR>"
)

keymap.set(
  { "n", "x" },
  ivim.keymaps.GotoImplementation,
  "<Cmd>lua require('vscode-neovim').action('editor.action.goToImplementation')<CR>"
)
keymap.set(
  { "n", "x" },
  ivim.keymaps.PeekImplementation,
  "<Cmd>lua require('vscode-neovim').action('editor.action.peekImplementation')<CR>"
)
-- keymap.set(
--   { "n", "x" },
--   ivim.keymaps.FormatDocument,
--   "<Cmd>lua require('vscode-neovim').call('editor.action.formatDocument', 'editor.action.organizeImports')<CR>"
-- )

keymap.set(
  { "n", "x" },
  ivim.keymaps.GotoDiagnosticPrev,
  "<Cmd>lua require('vscode-neovim').call('editor.action.marker.prev')<CR>"
)
keymap.set(
  { "n", "x" },
  ivim.keymaps.GotoDiagnosticNext,
  "<Cmd>lua require('vscode-neovim').call('editor.action.marker.next')<CR>"
)
