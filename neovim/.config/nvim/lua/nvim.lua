-- vim.keymap.set("n", "<C-h>", "^")
-- vim.keymap.set("n", "<C-l>", "$")

-- windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

-- terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Resize splits with arrow keys
vim.keymap.set("n", "<Up>", "<cmd>resize +5<cr>")
vim.keymap.set("n", "<Down>", "<cmd>resize -5<cr>")
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -5<cr>")
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +5<cr>")

-- buffers
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")

vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>")

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- vim.keymap.set("i", "<C-e>", "<End>")
-- vim.keymap.set("i", "<C-b>", "<Esc>^i")

_G.nvim = {
  version = vim.version().minor,
  home = os.getenv("HOME") .. "/.config/nvim",

  is_mac = jit.os == "OSX",
  is_linux = jit.os == "Linux",
  is_windows = vim.loop.os_uname().sysname == "Windows_NT",

  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  window = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    winblend = 0,
    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
  },
}
vim.env.PATH = vim.env.PATH .. (nvim.is_windows and ";" or ":") .. vim.fn.stdpath("data") .. "/mason/bin"

function nvim.find_lsp_root()
  local clients = vim.lsp.buf_get_clients()
  if next(clients) == nil then
    return nil
  end

  for _, client in pairs(clients) do
    if client.name ~= "null-ls" then
      return client.config.root_dir
    end
  end

  return nil
end
