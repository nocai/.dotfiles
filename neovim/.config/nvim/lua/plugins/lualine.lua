local icons = require("lazyvim.config").icons
-- LSP STUFF
function LSP_progress()
	if vim.o.columns < 120 then
		return ""
	end

	local Lsp = vim.lsp.util.get_progress_messages()[1]
	if not Lsp then
		return ""
	end

	local msg = Lsp.message or ""
	local percentage = Lsp.percentage or 0
	local title = Lsp.title or ""
	local spinners = { "", "" }
	local ms = vim.loop.hrtime() / 1000000
	local frame = math.floor(ms / 120) % #spinners
	local content = string.format("%%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
	return content or ""
end

-- LSP status
function LSP_status()
	if vim.o.columns < 70 then
		return ""
	end

	local names = {}
	for _, client in ipairs(vim.lsp.get_active_clients()) do
		if client.attached_buffers[vim.api.nvim_get_current_buf()] then
			table.insert(names, client.name)
		end
	end
	if vim.tbl_isempty(names) then
		return ""
	end

	return "  LSP ~ " .. vim.fn.join(names, "|") .. " "
end

local function fg(name)
	return function()
		---@type {foreground?:number}?
		local hl = vim.api.nvim_get_hl_by_name(name, true)
		return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
	end
end

return {
	{
		"nvim-lualine/lualine.nvim",
		cond = not vim.g.vscode,
		opts = function(plugin)
			return {
				options = {
					section_separators = '',
					component_separators = '',
					globalstatus = true,
				},
				sections = {
					lualine_a = {
						{ "mode", icon = "", separator = { left = "" } },
					},
					lualine_b = {
						{ "branch", separator = "|", section_separators = { left = "" } },
						{ "diff",   separator = "|", section_separators = { left = "" } },
						{
							"diagnostics",
							separator = "|",
							section_separators = { left = "" },
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
					},
					lualine_c = {
						{ "filetype", icon_only = true, separator = "", padding = { left = 1 } },
						{ "filename", path = 1,         separator = ">" },
						-- stylua: ignore
						{
							function() return require("nvim-navic").get_location() end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {
						{ LSP_status,  separator = "|" },
						{ LSP_progress },
					},
					lualine_y = {
						{ "%l:%v", icon = "", separator = { left = "" } },
					},
					lualine_z = {
						{ "%p%%", separator = { right = "" } },
					},
				},
			}
		end
	}
}
