local M = {}

function M.tokyonight()
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

	-- , bg_statusline = "none"
	vim.g.tokyonight_colors = { bg_float = "none", border = "bg" }
end

function M.nvim_tree()
	require("nvim-tree").setup({
		reload_on_bufenter = true,
		create_in_closed_folder = true,
		diagnostics = nvim.diagnostics,

		update_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_cwd = true,
			update_root = true,
		},

		renderer = {
			group_empty = true,
			highlight_opened_files = "name",
			indent_markers = {
				enable = true,
			},
			icons = {
				git_placement = "after", -- "signcolumn"
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
			adaptive_size = true,
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
	vim.api.nvim_create_autocmd("BufEnter", {
		nested = true,
		callback = function()
			if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
				vim.cmd("quit")
			end
		end,
	})
end

function M.lualine()
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
		return content or ""
		-- return content and "%=" .. content .. "%=" or ""
	end

	-- LSP status
	function LSP_status()
		local names = {}
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			if client.attached_buffers[vim.api.nvim_get_current_buf()] then
				table.insert(names, client.name)
			end
		end
		return vim.o.columns > 70 and "   LSP ~ " .. vim.fn.join(names, "|") .. " "
	end

	require("lualine").setup({
		sections = {
			lualine_a = {
				{
					"mode",
					icon = "",
					separator = { left = "", right = "" },
				},
			},
			lualine_c = {
				{ "filetype", icon_only = true, separator = "", padding = { left = 1 } },
				{ "filename", separator = "" },
				{ LSP_progress },
			},
			lualine_x = { { LSP_status } },
			lualine_y = {
				{ "%l:%v", icon = "", separator = { left = "" } },
			},
			lualine_z = {
				{ "%p%%", icon = "", separator = { right = "" } },
			},
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
		-- extensions = { "nvim-tree", "quickfix" },
	})
end

function M.alpha_nvim()
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
		dashboard.button("<C-k><C-f>", "  Find file", ":Telescope find_files<CR>"),
		dashboard.button("<C-k><C-g>", "  Find word", ":Telescope live_grep<CR>"),
		dashboard.button("<C-k><C-o>", "  Recently opened files", ":Telescope oldfiles<CR>"),
		dashboard.button("<C-k><C-p>", "  Projects", ":Telescope projects<CR>"),

		dashboard.button("k", "  New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
	}
	dashboard.opts.opts.noautocmd = true
	require("alpha").setup(dashboard.config)
end

function M.toggleterm()
	require("toggleterm").setup({
		-- insert_mappings = false,
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
	local glow = Terminal:new({
		cmd = "glow -p " .. vim.fn.expand("%"),
		hidden = true,
		direction = "float",
	})
	vim.api.nvim_create_user_command("Glow", function()
		glow:toggle()
	end, { nargs = "?" })

	-- lazygit
	local lazygit = Terminal:new({
		cmd = "lazygit",
		hidden = true,
		direction = "float",
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

function M.indent_blankline()
	require("indent_blankline").setup({
		-- for example, context is off by default, use this to turn it on
		show_current_context = true,
		-- show_current_context_start = true,
	})
end

function M.gitsigns()
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
			end, { expr = true })

			map('n', '[h', function()
				if vim.wo.diff then return '[h' end
				vim.schedule(function() gs.prev_hunk() end)
				return '<Ignore>'
			end, { expr = true })

			-- Actions
			map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
			map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
			map('n', '<leader>hS', gs.stage_buffer)
			map('n', '<leader>hu', gs.undo_stage_hunk)
			map('n', '<leader>hR', gs.reset_buffer)
			map('n', '<leader>hp', gs.preview_hunk)
			map('n', '<leader>hb', function() gs.blame_line { full = true } end)
			map('n', '<leader>tb', gs.toggle_current_line_blame)
			map('n', '<leader>hd', gs.diffthis)
			map('n', '<leader>hD', function() gs.diffthis('~') end)
			map('n', '<leader>td', gs.toggle_deleted)

			-- Text object
			map({ 'o', 'x' }, 'lh', ':<C-U>Gitsigns select_hunk<CR>')
			-- stylua: ignore end
		end,
	})
end

return M
