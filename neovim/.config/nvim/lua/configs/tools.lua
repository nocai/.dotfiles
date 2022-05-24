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

return tools
