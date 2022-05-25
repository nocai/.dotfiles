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

	-- bg_statusline = "none"
	vim.g.tokyonight_colors = { bg_float = "none" }
end

function ui.nvim_tree()
	vim.g.nvim_tree_group_empty = 1
	vim.g.nvim_tree_highlight_opened_files = 3
	vim.g.nvim_tree_respect_buf_cwd = 1

	vim.keymap.set("n", "<leader><leader>", "<cmd>NvimTreeFindFileToggle<CR>")

	local tree_cb = require("nvim-tree.config").nvim_tree_callback
	-- stylua: ignore
	require("nvim-tree").setup({
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				git_placement = "signcolumn",
			},
		},
		diagnostics = nvim.diagnostics,
		view = {
			mappings = {
				custom_only = true,
				list = {
					{ key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit")               },
					{ key = { "<2-RightMouse>", "<C-]>" },    cb = tree_cb("cd")                 },
					{ key = { "<C-v>", "v" },                 cb = tree_cb("vsplit")             },
					{ key = { "<C-x>", "s" },                 cb = tree_cb("split")              },
					{ key = "<C-t>",                          cb = tree_cb("tabnew")             },
					{ key = "<",                              cb = tree_cb("prev_sibling")       },
					{ key = ">",                              cb = tree_cb("next_sibling")       },
					{ key = "P",                              cb = tree_cb("parent_node")        },
					{ key = "<BS>",                           cb = tree_cb("close_node")         },
					{ key = "<S-CR>",                         cb = tree_cb("close_node")         },
					{ key = "<Tab>",                          cb = tree_cb("preview")            },
					{ key = "E",                              cb = tree_cb("first_sibling")      },
					{ key = "N",                              cb = tree_cb("last_sibling")       },
					{ key = "L",                              cb = tree_cb("toggle_ignored")     },
					{ key = "H",                              cb = tree_cb("toggle_dotfiles")    },
					{ key = "R",                              cb = tree_cb("refresh")            },
					{ key = "a",                              cb = tree_cb("create")             },
					{ key = "d",                              cb = tree_cb("remove")             },
					{ key = "r",                              cb = tree_cb("rename")             },
					{ key = "<C-r>",                          cb = tree_cb("full_rename")        },
					{ key = "x",                              cb = tree_cb("cut")                },
					{ key = "c",                              cb = tree_cb("copy")               },
					{ key = "p",                              cb = tree_cb("paste")              },
					{ key = "y",                              cb = tree_cb("copy_name")          },
					{ key = "Y",                              cb = tree_cb("copy_path")          },
					{ key = "gy",                             cb = tree_cb("copy_absolute_path") },
					{ key = "[c",                             cb = tree_cb("prev_git_item")      },
					{ key = "]c",                             cb = tree_cb("next_git_item")      },
					{ key = "-",                              cb = tree_cb("dir_up")             },
					-- { key = "s",                           cb = tree_cb("system_open")        },
					{ key = "q",                              cb = tree_cb("close")              },
					{ key = { "?", "g?" },                    cb = tree_cb("toggle_help")        },
				},
			},
		},
	})
	-- auto close last windows in the tab
	vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
end

function ui.lualine()
	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = true,
			-- component_separators = { left = "", right = "" },
			-- section_separators = { left = '', right = '' },
			-- section_separators = "",
			-- component_separators = "",
			-- section_separators = { left = "", right = "" },
			-- component_separators = { left = "", right = "" },
		},
		tabline = {
			lualine_a = {
				{
					"buffers",
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
						-- Same values as the general color option can be used here.
						active = "lualine_b_normal", -- Color for active window.
						inactive = "lualine_c_normal", -- Color for inactive window.
					},
				},
			},
			lualine_z = {
				{
					"tabs",
					tabs_color = {
						-- Same values as the general color option can be used here.
						active = "lualine_a_normal", -- Color for active tab.
						inactive = "lualine_c_normal", -- Color for inactive tab.
					},
					separator = { left = "" },
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
		dashboard.button("k", "  New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("q", "  Quit NVIM", ":qa<CR>"),

		dashboard.button("<C-k><C-f>", "  Find file"),
		dashboard.button("<C-k><C-o>", "  Recently opened files"),
		dashboard.button("<C-k><C-g>", "  Find word"),
		dashboard.button("<C-k><C-p>", "  Projects"),
	}
	require("alpha").setup(dashboard.config)
end

return ui
