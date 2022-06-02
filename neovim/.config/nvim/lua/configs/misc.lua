local misc = {}

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

function misc.vim_sandwich()
	vim.keymap.set({ "x", "o" }, "ls", "<Plug>(textobj-sandwich-query-i)")
	vim.keymap.set({ "x", "o" }, "as", "<Plug>(textobj-sandwich-query-a)")

	vim.keymap.set({ "x", "o" }, "lss", "<Plug>(textobj-sandwich-auto-i)")
	vim.keymap.set({ "x", "o" }, "ass", "<Plug>(textobj-sandwich-auto-a)")

	vim.keymap.set({ "x", "o" }, "lm", "<Plug>(textobj-sandwich-literal-query-i)")
	vim.keymap.set({ "x", "o" }, "am", "<Plug>(textobj-sandwich-literal-query-a)")
end

function misc.vim_textobj_indent()
	vim.keymap.set({ "x", "o" }, "li", "<Plug>(textobj-indent-i)")
	vim.keymap.set({ "x", "o" }, "lI", "<Plug>(textobj-indent-same-i)")

	vim.keymap.set({ "x", "o" }, "ai", "<Plug>(textobj-indent-a)")
	vim.keymap.set({ "x", "o" }, "aI", "<Plug>(textobj-indent-same-a)")
end

function misc.vim_textobj_parameter()
	vim.keymap.set({ "x", "o" }, "la", "<Plug>(textobj-parameter-i)")
	vim.keymap.set({ "x", "o" }, "aa", "<Plug>(textobj-parameter-a)")
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
		-- disable timer instead autocmd 'CursorHold'
		refresh_interval = 0,
		-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
		-- marks, and bookmarks.
		-- can be either a table with all/none of the keys, or a single number, in which case
		-- the priority applies to all marks.
		-- default 10.
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		-- disables mark tracking for specific filetypes. default {}
		excluded_filetypes = {},
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

return misc
