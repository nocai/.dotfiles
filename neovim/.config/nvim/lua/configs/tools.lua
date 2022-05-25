local tools = {}

function tools.gitsigns()
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
			map('n', ']c', function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function() gs.next_hunk() end)
				return '<Ignore>'
			end, {expr=true})

			map('n', '[c', function()
				if vim.wo.diff then return '[c' end
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

function tools.vim_quickrun()
	vim.g.quickrun_no_default_key_mappings = 1
	vim.g.quickrun_config = { _ = { outputter = "message" } }
	vim.keymap.set("n", "<leader>rr", "<Plug>(quickrun)")
end

function tools.vim_test()
	vim.cmd([[
		let test#strategy = "neovim"
		nmap <silent> <leader>tt :TestNearest -v<CR>
		nmap <silent> <leader>tl :TestLast -v<CR>
		nmap <silent> <leader>tv :TestVisit<CR>
	]])
end

function tools.comment()
	require("Comment").setup({
		pre_hook = function(ctx) -- for plugin: commentstring
			local U = require("Comment.utils")

			local location = nil
			if ctx.ctype == U.ctype.block then
				location = require("ts_context_commentstring.utils").get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = require("ts_context_commentstring.utils").get_visual_start_location()
			end

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
				location = location,
			})
		end,
	})
end

function tools.diffview()
	-- Lua
	local actions = require("diffview.config").actions

	require("diffview").setup({
		diff_binaries = false, -- Show diffs for binaries
		enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
		use_icons = true, -- Requires nvim-web-devicons
		icons = { -- Only applies when use_icons is true.
			folder_closed = "",
			folder_open = "",
		},
		signs = {
			fold_closed = "",
			fold_open = "",
		},
		file_panel = {
			listing_style = "tree", -- One of 'list' or 'tree'
			tree_options = { -- Only applies when listing_style is 'tree'
				flatten_dirs = true, -- Flatten dirs that only contain one single dir
				folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
			},
			win_config = { -- See ':h diffview-config-win_config'
				position = "left",
				width = 35,
			},
		},
		file_history_panel = {
			log_options = {
				max_count = 256, -- Limit the number of commits
				follow = false, -- Follow renames (only for single file)
				all = false, -- Include all refs under 'refs/' including HEAD
				merges = false, -- List only merge commits
				no_merges = false, -- List no merge commits
				reverse = false, -- List commits in reverse order
			},
			win_config = { -- See ':h diffview-config-win_config'
				position = "bottom",
				height = 16,
			},
		},
		commit_log_panel = {
			win_config = {}, -- See ':h diffview-config-win_config'
		},
		default_args = { -- Default args prepended to the arg-list for the listed commands
			DiffviewOpen = {},
			DiffviewFileHistory = {},
		},
		hooks = {}, -- See ':h diffview-config-hooks'
		keymaps = {
			disable_defaults = false, -- Disable the default keymaps
			view = {
				-- The `view` bindings are active in the diff buffers, only when the current
				-- tabpage is a Diffview.
				["<tab>"] = actions.select_next_entry, -- Open the diff for the next file
				["<s-tab>"] = actions.select_prev_entry, -- Open the diff for the previous file
				["gf"] = actions.goto_file, -- Open the file in a new split in previous tabpage
				["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
				["<C-w>gf"] = actions.goto_file_tab, -- Open the file in a new tabpage
				["<leader>e"] = actions.focus_files, -- Bring focus to the files panel
				["<leader>b"] = actions.toggle_files, -- Toggle the files panel.
			},
			file_panel = {
				["j"] = actions.next_entry, -- Bring the cursor to the next file entry
				["<down>"] = actions.next_entry,
				["k"] = actions.prev_entry, -- Bring the cursor to the previous file entry.
				["<up>"] = actions.prev_entry,
				["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
				["o"] = actions.select_entry,
				["<2-LeftMouse>"] = actions.select_entry,
				["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
				["S"] = actions.stage_all, -- Stage all entries.
				["U"] = actions.unstage_all, -- Unstage all entries.
				["X"] = actions.restore_entry, -- Restore entry to the state on the left side.
				["R"] = actions.refresh_files, -- Update stats and entries in the file list.
				["L"] = actions.open_commit_log, -- Open the commit log panel.
				["<tab>"] = actions.select_next_entry,
				["<s-tab>"] = actions.select_prev_entry,
				["gf"] = actions.goto_file,
				["<C-w><C-f>"] = actions.goto_file_split,
				["<C-w>gf"] = actions.goto_file_tab,
				["i"] = actions.listing_style, -- Toggle between 'list' and 'tree' views
				["f"] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
				["<leader>e"] = actions.focus_files,
				["<leader>b"] = actions.toggle_files,
			},
			file_history_panel = {
				["g!"] = actions.options, -- Open the option panel
				["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
				["y"] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
				["L"] = actions.open_commit_log,
				["zR"] = actions.open_all_folds,
				["zM"] = actions.close_all_folds,
				["j"] = actions.next_entry,
				["<down>"] = actions.next_entry,
				["k"] = actions.prev_entry,
				["<up>"] = actions.prev_entry,
				["<cr>"] = actions.select_entry,
				["o"] = actions.select_entry,
				["<2-LeftMouse>"] = actions.select_entry,
				["<tab>"] = actions.select_next_entry,
				["<s-tab>"] = actions.select_prev_entry,
				["gf"] = actions.goto_file,
				["<C-w><C-f>"] = actions.goto_file_split,
				["<C-w>gf"] = actions.goto_file_tab,
				["<leader>e"] = actions.focus_files,
				["<leader>b"] = actions.toggle_files,
			},
			option_panel = {
				["<tab>"] = actions.select_entry,
				["q"] = actions.close,
			},
		},
	})
end
return tools
