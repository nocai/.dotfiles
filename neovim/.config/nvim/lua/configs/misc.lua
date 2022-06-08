local misc = {}

function misc.nvim_lsp_installer()
	require("nvim-lsp-installer").setup({
		automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
		ui = {
			keymaps = {
				-- Keymap to install the server under the current cursor position
				install_server = "l",
			},
		},
		github = {
			-- The template URL to use when downloading assets from GitHub.
			-- The placeholders are the following (in order):
			-- 1. The repository (e.g. "rust-lang/rust-analyzer")
			-- 2. The release version (e.g. "v0.3.0")
			-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
			download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
		},
	})
end

function misc.null_ls()
	local ls = require("null-ls")
	ls.setup({
		sources = {
			ls.builtins.formatting.stylua,
		},
	})
end

function misc.lsp_signature()
	require("lsp_signature").setup({
		bind = true,
		floating_window = true,
		hint_enable = false,
		floating_window_above_cur_line = true,
		timer_interval = 1000,
		handler_opts = {
			border = "rounded", -- double, single, shadow, none
		},
	})
end

function misc.symbols_outline()
	-- init.lua
	vim.g.symbols_outline = {
		auto_preview = false,
		auto_close = false,
		width = 20,
		preview_bg_highlight = "Normal",
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = { "<CR>", "<2-LeftMouse>" },
			focus_location = "o",
			hover_symbol = { "<C-e>", "E" },
			toggle_preview = "<C-p>",
			rename_symbol = { "gn", "r" },
			code_actions = { "ga", "ca" },
		},
	}
	vim.keymap.set("n", "gO", "<cmd>SymbolsOutline<cr>")
	vim.cmd("hi link FocusedSymbol PmenuSel")

	-- auto close symbols-outline window when it is the last window
	nvim.set_symbols_outline_state = function()
		vim.g["symbols_outline_state"] = require("symbols-outline").state
	end

	vim.cmd([[
		autocmd BufEnter * :lua nvim.set_symbols_outline_state()
		autocmd BufEnter * if winnr('$') == 1 && exists('g:symbols_outline_state.outline_buf') && g:symbols_outline_state.outline_buf | quit | endif
	]])
end

function misc.sonokai()
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

function misc.tokyonight()
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

function misc.nvim_tree()
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
					{ key = "<C-p>", action = "preview" },
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

function misc.lualine()
	-- LSP STUFF
	function LSP_progress()
		local Lsp = vim.lsp.util.get_progress_messages()[1]

		if vim.o.columns < 120 or not Lsp then
			return ""
		end

		local msg = Lsp.message or ""
		local percentage = Lsp.percentage or 0
		local title = Lsp.title or ""
		local spinners = { "", "" }
		local ms = vim.loop.hrtime() / 1000000
		local frame = math.floor(ms / 120) % #spinners
		local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

		return ("%#St_LspProgress#" .. content) or ""
	end
	-- LSP status
	function LSP_status()
		local lsp_attached = next(vim.lsp.buf_get_clients()) ~= nil
		local content = lsp_attached and "   LSP ~ " .. vim.lsp.get_active_clients()[1].name .. " " or false
		return content and ("%#St_LspStatus#" .. content) or ""
	end

	function GPS()
		if vim.o.columns < 140 or not package.loaded["nvim-gps"] then
			return ""
		end

		local gps = require("nvim-gps")
		return (gps.is_available() and gps.get_location()) or ""
	end

	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = true,
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "", right = "" } } },
			lualine_c = { { "filename" }, { GPS }, { LSP_progress } },
			lualine_x = { { LSP_status }, "encoding", "fileformat", "filetype" },
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

function misc.nvim_bufferline()
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

function misc.dressing()
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

function misc.alpha_nvim()
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

function misc.notify()
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

function misc.neoscroll()
	require("neoscroll").setup({
		mappings = {
			"<C-u>",
			"<C-d>",
			"<C-b>",
			"<C-f>",
			"<C-y>",
			"zt",
			"zz",
			"zb",
		},
	})
	require("neoscroll.config").set_mappings({ ["<C-j>"] = { "scroll", { "0.10", "false", "100" } } })
end

function misc.indent_blankline()
	require("indent_blankline").setup({
		-- for example, context is off by default, use this to turn it on
		show_current_context = true,
		-- show_current_context_start = true,
	})
end

function misc.toggleterm()
	require("toggleterm").setup({
		open_mapping = [[<C-\>]], -- mapping to <C-`>
		direction = "float",
		float_opts = {
			border = "curved",
		},
		highlights = {
			FloatBorder = {
				link = "FloatBorder",
			},
		},
	})

	local Terminal = require("toggleterm.terminal").Terminal

	-- glow
	local glow = Terminal:new({ cmd = "glow -p " .. vim.fn.expand("%"), hidden = true })
	vim.api.nvim_create_user_command("Glow", function()
		glow:toggle()
	end, { nargs = "?" })

	-- lazygit
	local lazygit = Terminal:new({
		cmd = "lazygit",
		hidden = true,
		on_open = function()
			vim.keymap.del("t", "<Esc>")
		end,
		on_close = function()
			vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
		end,
	})
	vim.keymap.set("n", "<leader>gg", function()
		lazygit:toggle()
	end, { silent = true })
	vim.api.nvim_create_user_command("Lazygit", function()
		lazygit:toggle()
	end, {})
end

function misc.marks()
	require("marks").setup({
		default_mappings = true,
		mappings = {
			toggle = "m.",
		},
		-- which builtin marks to show. default {}
		builtin_marks = { ".", "<", ">", "^" },
		-- disables mark tracking for specific filetypes. default {}
		excluded_filetypes = { "", "toggleterm" },

		-- disable timer instead autocmd 'CursorHold'
		refresh_interval = 0,
		-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
		-- marks, and bookmarks.
		-- can be either a table with all/none of the keys, or a single number, in which case
		-- the priority applies to all marks.
		-- default 10.
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
		-- sign/virttext. Bookmarks can be used to group together positions and quickly move
		-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
		-- default virt_text is "".
		bookmark_0 = {
			sign = "⚑",
			-- virt_text = "hello world",
		},
	})
	vim.cmd([[au CursorHold * lua require'marks'.refresh()]])
end

function misc.gitsigns()
	require("gitsigns").setup({
		current_line_blame = true,
		preview_config = {
			-- Options passed to nvim_open_win
			border = "rounded",
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- stylua: ignore start
			-- Navigation
			map('n', ']h', function()
				if vim.wo.diff then return ']h' end
					vim.schedule(function() gs.next_hunk() end)
				return '<Ignore>'
			end, {expr=true})

			map('n', '[h', function()
				if vim.wo.diff then return '[h' end
					vim.schedule(function() gs.prev_hunk() end)
				return '<Ignore>'
			end, {expr=true})

			-- Actions
			map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
			map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
			map('n', '<leader>hS', gs.stage_buffer)
			map('n', '<leader>hu', gs.undo_stage_hunk)
			map('n', '<leader>hR', gs.reset_buffer)
			map('n', '<leader>hp', gs.preview_hunk)
			map('n', '<leader>hb', function() gs.blame_line{full=true} end)
			map('n', '<leader>tb', gs.toggle_current_line_blame)
			map('n', '<leader>hd', gs.diffthis)
			map('n', '<leader>hD', function() gs.diffthis('~') end)
			map('n', '<leader>td', gs.toggle_deleted)

			-- Text object
			map({'o', 'x'}, 'lh', ':<C-U>Gitsigns select_hunk<CR>')
			-- stylua: ignore end
		end,
	})
end

function misc.vim_quickrun()
	vim.g.quickrun_no_default_key_mappings = 1
	vim.g.quickrun_config = { _ = { outputter = "message" } }
	vim.keymap.set("n", "<leader>rr", "<Plug>(quickrun)")
end

function misc.vim_test()
	vim.cmd([[
		let test#strategy = "neovim"
		nmap <silent> <leader>tt :TestNearest -v<CR>
		nmap <silent> <leader>tl :TestLast -v<CR>
		nmap <silent> <leader>tv :TestVisit<CR>
	]])
end

return misc
