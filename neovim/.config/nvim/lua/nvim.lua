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

	vim.api.nvim_create_autocmd(tb.events, {
		pattern = "*",
		group = vim.api.nvim_create_augroup(tb.augroup_name, {}),
		callback = function()
			if tb.condition() then
				-- print("in condition:", tb.plugins)
				vim.api.nvim_del_augroup_by_name(tb.augroup_name)

				-- dont defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if tb.plugins ~= "nvim-treesitter" then
					vim.defer_fn(function()
						vim.cmd("PackerLoad " .. tb.plugins)
					end, 0)
				else
					vim.cmd("PackerLoad " .. tb.plugins)
				end
			end
		end,
	})
end
