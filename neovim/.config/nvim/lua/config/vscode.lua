local keymap = vim.keymap

vim.cmd([[
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
  ]])

keymap.set("n", "<leader>e", "<Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>")
keymap.set("n", "<leader><space>", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")

keymap.set(
  { "n", "x" },
  ivim.lsp_keys.GotoReferences,
  "<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>"
)
keymap.set({ "n" }, ivim.lsp_keys.Rename, "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")
keymap.set({ "n" }, ivim.lsp_keys.CodeLens, "<Cmd>call VSCodeNotify('codelens.showLensesInCurrentLine')<CR>")
keymap.set({ "n", "x" }, ivim.lsp_keys.CodeActions, "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>")

keymap.set(
  { "n", "x" },
  ivim.lsp_keys.GotoTypeDefinition,
  "<Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>"
)
keymap.set(
  { "n", "x" },
  ivim.lsp_keys.PeekTypeDefinition,
  "<Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>"
)

keymap.set(
  { "n", "x" },
  ivim.lsp_keys.GotoImplementation,
  "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>"
)
keymap.set(
  { "n", "x" },
  ivim.lsp_keys.PeekImplementation,
  "<Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>"
)
keymap.set({ "n", "x" }, ivim.lsp_keys.FormatDocument, "<Cmd>call VSCodeCall('editor.action.formatDocument')<CR>")

keymap.set({ "n", "x" }, ivim.lsp_keys.DiagnosticPrev, "<Cmd>call VSCodeCall('editor.action.marker.prev')<CR>")
keymap.set({ "n", "x" }, ivim.lsp_keys.DiagnosticNext, "<Cmd>call VSCodeCall('editor.action.marker.next')<CR>")
