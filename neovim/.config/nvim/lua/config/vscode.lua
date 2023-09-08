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
  ivim.keymaps.GotoReferences,
  "<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>"
)
keymap.set({ "n" }, ivim.keymaps.Rename, "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")
keymap.set({ "n" }, ivim.keymaps.CodeLens, "<Cmd>call VSCodeNotify('codelens.showLensesInCurrentLine')<CR>")
keymap.set({ "n", "x" }, ivim.keymaps.CodeActions, "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>")

keymap.set(
  { "n", "x" },
  ivim.keymaps.GotoTypeDefinition,
  "<Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>"
)
keymap.set(
  { "n", "x" },
  ivim.keymaps.PeekTypeDefinition,
  "<Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>"
)

keymap.set(
  { "n", "x" },
  ivim.keymaps.GotoImplementation,
  "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>"
)
keymap.set(
  { "n", "x" },
  ivim.keymaps.PeekImplementation,
  "<Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>"
)
keymap.set({ "n", "x" }, ivim.keymaps.FormatDocument, "<Cmd>call VSCodeCall('editor.action.formatDocument')<CR>")

keymap.set({ "n", "x" }, ivim.keymaps.DiagnosticPrev, "<Cmd>call VSCodeCall('editor.action.marker.prev')<CR>")
keymap.set({ "n", "x" }, ivim.keymaps.DiagnosticNext, "<Cmd>call VSCodeCall('editor.action.marker.next')<CR>")
