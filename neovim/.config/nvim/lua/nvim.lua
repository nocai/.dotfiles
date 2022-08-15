-- windows
vim.keymap.set("n", "<M-h>", "<C-w><C-h>")
vim.keymap.set("n", "<M-j>", "<C-w><C-j>")
vim.keymap.set("n", "<M-k>", "<C-w><C-k>")
vim.keymap.set("n", "<M-l>", "<C-w><C-l>")

-- terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-w>l")

-- Resize splits with arrow keys
vim.keymap.set("n", "<Up>", "<cmd>res +5<cr>")
vim.keymap.set("n", "<Down>", "<cmd>res -5<cr>")
vim.keymap.set("n", "<Left>", "<cmd>vertical resize-5<cr>")
vim.keymap.set("n", "<Right>", "<cmd>vertical resize+5<cr>")

-- buffers
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>")

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")

_G.nvim = {
	version = vim.version().minor,
	home = os.getenv("HOME") .. "/.config/nvim",

	is_mac = jit.os == "OSX",
	is_linux = jit.os == "Linux",
	is_vscode = vim.g.vscode == 1,
	is_not_vscode = vim.g.vscode ~= 1,

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

-- https://github.com/max397574/omega-nvim/blob/master/lua/omega/modules/ui/bufferline.lua
function nvim.lazy_load(tb)
	if tb.disable ~= nil and tb.disable then
		return
	end

	local file = vim.fn.expand("%")
	if file == "NvimTree_1" or file == "[packer]" or file == "" then
		return
	end

	local augroup = "LazyLoadAuGroup_Rand:" .. vim.fn.rand()
	vim.api.nvim_create_autocmd(tb.events, {
		pattern = "*",
		group = vim.api.nvim_create_augroup(augroup, {}),
		callback = function()
			if tb.condition and not tb.condition() then
				return
			end

			vim.api.nvim_del_augroup_by_name(augroup)
			if tb.setup ~= nil then
				tb.setup()
			end

			-- dont defer for treesitter as it will show slow highlighting
			-- This deferring only happens only when we do "nvim filename"
			if tb.plugins ~= "nvim-treesitter" then
				vim.defer_fn(function()
					vim.cmd("PackerLoad " .. tb.plugins)
				end, 0)
			else
				vim.cmd("PackerLoad " .. tb.plugins)
			end
		end,
	})
end

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
