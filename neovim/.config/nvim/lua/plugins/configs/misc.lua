local misc = {}

function misc.symbols_outline()
	local lspkind_icon = require("core.lspkind_icon")
	vim.g.symbols_outline = {
		auto_preview = false,
		auto_close = true,
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
		symbols = {
			File = { icon = lspkind_icon.Field, hl = "TSURI" },
			Module = { icon = lspkind_icon.Module, hl = "TSNamespace" },
			Namespace = { icon = lspkind_icon.Namespace, hl = "TSNamespace" },
			Package = { icon = lspkind_icon.Module, hl = "TSNamespace" },
			Class = { icon = lspkind_icon.Class, hl = "TSType" },
			Method = { icon = lspkind_icon.Method, hl = "TSMethod" },
			Property = { icon = lspkind_icon.Property, hl = "TSMethod" },
			Field = { icon = lspkind_icon.Field, hl = "TSField" },
			Constructor = { icon = lspkind_icon.Constructor, hl = "TSConstructor" },
			Enum = { icon = lspkind_icon.Enum, hl = "TSType" },
			Interface = { icon = lspkind_icon.Interface, hl = "TSType" },
			Function = { icon = lspkind_icon.Function, hl = "TSFunction" },
			Variable = { icon = lspkind_icon.Variable, hl = "TSConstant" },
			Constant = { icon = lspkind_icon.Constant, hl = "TSConstant" },
			String = { icon = lspkind_icon.String, hl = "TSString" },
			Number = { icon = lspkind_icon.Number, hl = "TSNumber" },
			Boolean = { icon = lspkind_icon.Boolean, hl = "TSBoolean" },
			Array = { icon = lspkind_icon.Array, hl = "TSConstant" },
			Object = { icon = lspkind_icon.Object, hl = "TSType" },
			Key = { icon = lspkind_icon.Keyword, hl = "TSType" },
			Null = { icon = lspkind_icon.Keyword, hl = "TSType" },
			EnumMember = { icon = lspkind_icon.EnumMember, hl = "TSField" },
			Struct = { icon = lspkind_icon.Struct, hl = "TSType" },
			Event = { icon = lspkind_icon.Event, hl = "TSType" },
			Operator = { icon = lspkind_icon.Operator, hl = "TSOperator" },
			TypeParameter = { icon = lspkind_icon.TypeParameter, hl = "TSParameter" },
		},
	}
	vim.keymap.set("n", "gO", "<cmd>SymbolsOutline<cr>")
	vim.cmd("hi link FocusedSymbol PmenuSel")

	-- -- auto close symbols-outline window when it is the last window
	-- nvim.set_symbols_outline_state = function()
	-- 	vim.g["symbols_outline_state"] = require("symbols-outline").state
	-- end
	--
	-- vim.cmd([[
	-- 	autocmd BufEnter * :lua nvim.set_symbols_outline_state()
	-- 	autocmd BufEnter * if winnr('$') == 1 && exists('g:symbols_outline_state.outline_buf') && g:symbols_outline_state.outline_buf | quit | endif
	-- ]])
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
		sign_priority = { lower = 8, upper = 8, builtin = 8, bookmark = 20 },
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



function misc.vim_quickrun()
	vim.g.quickrun_no_default_key_mappings = 1
	vim.g.quickrun_config = { _ = { outputter = "message" } }
	vim.keymap.set("n", "<leader>rr", "<Plug>(quickrun)")
end

function misc.vim_test()
	vim.cmd([[
		let test#strategy = "neovim"
		nmap <silent> <leader>tt :TestNearest -v<CR>
		nmap <silent> <leader>tf :TestFile<CR>
		nmap <silent> <leader>ts :TestSuite<CR>
		nmap <silent> <leader>tl :TestLast -v<CR>
		nmap <silent> <leader>tv :TestVisit<CR>
	]])
end

return misc
