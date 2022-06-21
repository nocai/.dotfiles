_G.nvim = {
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
