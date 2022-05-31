-- about UI
--
local ui = {}

function ui.sonokai()
	-- Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
	-- Default value: `'default'`
	vim.g.sonokai_style = "shusia"
	-- Available values: `'auto'`, `'red'`, `'orange'`, `'yellow'`, `'green'`, `'blue'`, `'purple'`
	-- Default value: `'auto'`
	vim.g.sonokai_cursor = "red"
	vim.g.sonokai_enable_italic = 1
	vim.g.sonokai_disable_italic_comment = 0
	vim.g.sonokai_transparent_background = 1
	vim.g.sonokai_better_performance = 1
end

function ui.tokyonight()
	-- storm/night/day
	vim.g.tokyonight_style = "storm"

	vim.g.tokyonight_italic_comments = true
	vim.g.tokyonight_italic_keywords = true
	vim.g.tokyonight_italic_functions = true
	vim.g.tokyonight_italic_variables = true
	vim.g.tokyonight_lualine_bold = true

	vim.g.tokyonight_transparent = true
	vim.g.tokyonight_transparent_sidebar = true
	vim.g.tokyonight_dark_float = true

	vim.g.tokyonight_hide_inactive_statusline = true
	vim.g.tokyonight_terminal_colors = true

	vim.g.tokyonight_colors = { bg_float = "none", border = "bg" }
end

function ui.nvim_tree()
	require("nvim-tree").setup({
		hijack_cursor = true,
		reload_on_bufenter = true,
		diagnostics = nvim.diagnostics,

		update_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_cwd = false,
		},
		renderer = {
			group_empty = true,
			highlight_opened_files = "all",
			indent_markers = {
				enable = true,
				icons = { corner = "╰ ", edge = "┊ " },
			},
			icons = {
				git_placement = "signcolumn",
				glyphs = {
					git = {
						unstaged = "✗",
						staged = "✓",
						untracked = "",
					},
				},
			},
		},
		view = {
			mappings = {
				list = {
					{ key = "<C-k>", action = "" },
					{ key = "<C-e>", action = "toggle_file_info" },
					{ key = "J", action = "" },
					{ key = "N", action = "last_sibling" },
					{ key = "K", action = "" },
					{ key = "E", action = "first_sibling" },
					{ key = "I", action = "" },
					{ key = "L", action = "toggle_ignored" },
					{ key = { "?", "g?" }, action = "toggle_help" },
				},
			},
		},
	})

	vim.keymap.set("n", "<leader><leader>", "<cmd>NvimTreeFindFileToggle<CR>")
	-- auto close last windows in the tab
	vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
end

function ui.lualine()
	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = true,
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "", right = "" } } },
			lualine_y = { { "progress", separator = { left = "", right = "" } } },
			lualine_z = { { "location", separator = { left = "", right = "" } } },
		},
		tabline = {
			lualine_a = {
				{
					"buffers",
					mode = 2,
					buffers_color = {
						-- Same values as the general color option can be used here.
						active = "lualine_b_normal", -- Color for active buffer.
						inactive = "lualine_c_normal", -- Color for inactive buffer.
					},
				},
			},
			lualine_y = {
				{
					"windows",
					windows_color = {
						active = "lualine_b_normal",
						inactive = "lualine_c_normal",
					},
				},
			},
			lualine_z = {
				{
					"tabs",
					tabs_color = {
						active = "lualine_a_normal",
						inactive = "lualine_c_normal",
					},
				},
			},
		},
		extensions = { "nvim-tree", "quickfix" },
	})
end

function ui.nvim_bufferline()
	require("bufferline").setup({
		options = {
			indicator_icon = "",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, _, _)
				if nvim.diagnostics.enable then
					local icon = level:match("error") and nvim.diagnostics.icons.error or nvim.diagnostics.icons.hint
					return icon .. " " .. count
				end
				return " " .. count
			end,
			offsets = { { filetype = "NvimTree", text = "Press g? for help", text_align = "left", padding = 1 } },
		},
	})
end

function ui.dressing()
	require("dressing").setup({
		input = {
			-- Set to false to disable the vim.ui.input implementation
			enabled = true,
			-- Window transparency (0-100)
			winblend = nvim.window.winblend,
			-- Change default highlight groups (see :help winhl)
			winhighlight = nvim.window.winhighlight,
		},
		select = {
			-- Options for built-in selector
			builtin = {
				-- Window transparency (0-100)
				winblend = nvim.window.winblend,
				-- Change default highlight groups (see :help winhl)
				winhighlight = nvim.window.winhighlight,
			},
		},
	})
end

function ui.alpha_nvim()
	local dashboard = require("alpha.themes.dashboard")
	-- dashboard.section.header.val = {
	-- 	[[                               __                ]],
	-- 	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	-- 	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	-- 	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	-- 	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	-- 	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	-- }
	dashboard.section.buttons.val = {
		dashboard.button("<C-k><C-f>", "  Find file"),
		dashboard.button("<C-k><C-g>", "  Find word"),
		dashboard.button("<C-k><C-o>", "  Recently opened files"),
		dashboard.button("<C-k><C-p>", "  Projects"),

		dashboard.button("k", "  New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
	}
	dashboard.opts.opts.noautocmd = true
	require("alpha").setup(dashboard.config)
end

function ui.notify()
	local notify = require("notify")
	notify.setup({
		background_colour = "Pmenu",
	})
	vim.notify = notify

	local present, telescope = pcall(require, "telescope")
	if present then
		telescope.load_extension("notify")
	end
end

return ui
