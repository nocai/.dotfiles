local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")
local colors = require("tokyonight.colors").setup({})

local lsp_get_diag = function(str)
	local count = vim.lsp.diagnostic.get_count(0, str)
	return (count > 0) and ' ' .. count .. ' ' or ''
end

-- Initialize the components table
local components = {
	active = {},
	inactive = {}
}

-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})

-- Insert a component that will be on the left side of the statusline
-- when the window is active:
table.insert(components.active[1], {
	provider = function()
		return vi_mode_utils.get_vim_mode() .. " "
	end,
	icon = '  ',
	hl = function()
		return {
			-- name = vi_mode_utils.get_mode_highlight_name(),
			-- bg = vi_mode_utils.get_mode_color(),
			bg = colors.red,
			fg = colors.black,
			style = 'bold'
		}
	end,
	left_sep = '',
	right_sep = {
		str = '',
		hl = {
			fg = colors.red,
			bg = colors.fg_gutter,
		}
	}
})

-- Insert another component that will be on the left side of the statusline
-- when the window is active:
table.insert(components.active[1], {
	-- Component info here
	provider = 'git_branch',
	icon = '  ',
	hl = {
		fg = colors.blue,
		bg = colors.fg_gutter,
		style = 'bold'
	},
	right_sep = {
		str = '',
		hl = {
			fg = colors.blue,
			bg = colors.fg_gutter,
		}
	},
	enabled = function()
		return vim.b.gitsigns_status_dict ~= nil
	end,
})

table.insert(components.active[1], {
	provider = 'git_diff_added',
	hl = {
		fg = colors.blue,
		bg = colors.fg_gutter,
	},
})
-- Insert a component that will be on the middle of the statusline
-- when the window is active:
table.insert(components.active[2], {
	-- Component info here
	-- 			{
	-- 				provider = 'git_diff_changed',
	-- 				hl = {
	-- 					fg = colors.orange
	-- 				}
	-- 			},
	-- 			{
	-- 				provider = 'git_diff_removed',
	-- 				hl = {
	-- 					fg = colors.red
	-- 				}
	-- 			},
})

-- Insert a component that will be on the right side of the statusline
-- when the window is active:
table.insert(components.active[3], {
	-- Component info here
})

-- Insert a component that will be on the left side of the statusline
-- when the window is inactive:
table.insert(components.inactive[1], {
	-- Component info here
})

-- Insert a component that will be on the right side of the statusline
-- when the window is inactive:
table.insert(components.inactive[2], {
	-- Component info here
})

require("feline").setup({
	theme = {
		bg = colors.bg_statusline,
		fg = colors.fg,
		yellow = colors.yellow,
		cyan = colors.cyan,
		darkblue = colors.blue0,
		green = colors.green,
		orange = colors.orange,
		violet = colors.purple,
		magenta = colors.magenta,
		blue = colors.blue,
		red = colors.red,
		light_bg = colors.bg_highlight,
		primary_blue = colors.blue5,
	},
	vi_mode_colors = {
		NORMAL = colors.primary_blue,
		OP = colors.primary_blue,
		INSERT = colors.yellow,
		VISUAL = colors.magenta,
		LINES = colors.magenta,
		BLOCK = colors.magenta,
		REPLACE = colors.red,
		['V-REPLACE'] = colors.red,
		ENTER = colors.cyan,
		MORE = colors.cyan,
		SELECT = colors.orange,
		COMMAND = colors.blue,
		SHELL = colors.green,
		TERM = colors.green,
		NONE = colors.green,
	},
	components = components,
	-- components = {
	-- 	active = {
	-- 		-- left
	-- 		{
	-- 			{
	-- 				provider = {
	-- 					name = 'file_info',
	-- 					opts = {
	-- 						type = 'relative-short',
	-- 						file_readonly_icon = '  ',
	-- 						-- file_readonly_icon = '  ',
	-- 						-- file_readonly_icon = '  ',
	-- 						-- file_readonly_icon = '  ',
	-- 						-- file_modified_icon = '',
	-- 						-- file_modified_icon = '',
	-- 						-- file_modified_icon = 'ﱐ',
	-- 						-- file_modified_icon = '',
	-- 						-- file_modified_icon = '',
	-- 						-- file_modified_icon = '',
	-- 					}
	-- 				},
	-- 				hl = {
	-- 					fg = colors.blue,
	-- 					style = 'bold'
	-- 				}
	-- 			},
	-- 			{
	-- 				-- provider = 'diagnostic_errors',
	-- 				provider = function()
	-- 					return '' .. lsp_get_diag("Error")
	-- 				end,
	-- 				-- left_sep = ' ',
	-- 				enabled = function() return lsp.diagnostics_exist('Error') end,
	-- 				hl = {
	-- 					fg = colors.red
	-- 				}
	-- 			},
	-- 			{
	-- 				-- provider = 'diagnostic_warnings',
	-- 				provider = function()
	-- 					return '' .. lsp_get_diag("Warning")
	-- 				end,
	-- 				-- left_sep = ' ',
	-- 				enabled = function() return lsp.diagnostics_exist('Warn') end,
	-- 				hl = {
	-- 					fg = colors.yellow
	-- 				}
	-- 			},
	-- 			{
	-- 				-- provider = 'diagnostic_info',
	-- 				provider = function()
	-- 					return '' .. lsp_get_diag("Information")
	-- 				end,
	-- 				-- left_sep = ' ',
	-- 				enabled = function() return lsp.diagnostics_exist('Info') end,
	-- 				hl = {
	-- 					fg = colors.blue
	-- 				}
	-- 			},
	-- 			{
	-- 				-- provider = 'diagnostic_hints',
	-- 				provider = function()
	-- 					return '' .. lsp_get_diag("Hint")
	-- 				end,
	-- 				-- left_sep = ' ',
	-- 				enabled = function() return lsp.diagnostics_exist('Hint') end,
	-- 				hl = {
	-- 					fg = colors.cyan
	-- 				}
	-- 			},
	-- 		},
	--
	-- 		-- right
	-- 		{
	-- 			{
	-- 				provider = 'position',
	-- 				left_sep = ' ',
	-- 				hl = {
	-- 					fg = colors.cyan,
	-- 					-- style = 'bold'
	-- 				}
	-- 			},
	-- 			{
	-- 				provider = 'line_percentage',
	-- 				left_sep = ' ',
	-- 				hl = {
	-- 					style = 'bold'
	-- 				}
	-- 			}
	-- 		},
	-- 	},
	-- 	inactive = {},
	-- },
	force_inactive = {
		filetypes = {
			'packer',
			'NvimTree',
			'fugitive',
			'fugitiveblame'
		},
		buftypes = { 'terminal' },
		bufnames = {}
	}
})
