local M = {}

function M.toggleterm()
	require("toggleterm").setup({
		-- insert_mappings = false,
		open_mapping = [[<C-\>]], -- [[<C-Space>]] }, -- mapping to <C-`>
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
			map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
			-- stylua: ignore end
		end,
	})
end

function M.vim_quickrun()
	vim.g.quickrun_no_default_key_mappings = 1
	vim.g.quickrun_config = { _ = { outputter = "message" } }
	vim.keymap.set("n", "<leader>rr", "<Plug>(quickrun)")
end

function M.vim_test()
	vim.cmd([[
		let test#strategy = "neovim"
		nmap <silent> <leader>tt <cmd>TestNearest<CR>
		nmap <silent> <leader>tf <cmd>TestFile<CR>
		nmap <silent> <leader>ts <cmd>TestSuite<CR>
		nmap <silent> <leader>tl <cmd>TestLast<CR>
		nmap <silent> <leader>tv <cmd>TestVisit<CR>
	]])
end

function M.nvim_test()
	require("nvim-test.runners.cargo-test"):setup({
		command = "RUST_TEST_NOCAPTURE=1 cargo", -- env在toggleterm下不生效
		env = { RUST_TEST_NOCAPTURE = 1 },
		package = true,
	})

	require("nvim-test").setup({
		term = "toggleterm",
		termOpts = {
			direction = "float", -- terminal's direction ("horizontal"|"vertical"|"float")
		},
	})

	-- TestSuite - run the whole test suite
	-- TestFile - run all tests for the current file
	-- TestEdit - edit tests for the current file
	-- TestNearest - run the test nearest to the cursor
	-- TestLast - rerun the latest test
	-- TestVisit - open the last run test in the current buffer
	-- TestInfo - show an information about the plugin
	vim.keymap.set("n", "<Leader>tt", "<cmd>TestNearest<cr>")
	vim.keymap.set("n", "<Leader>tn", "<cmd>TestNearest<cr>")
	vim.keymap.set("n", "<Leader>tl", "<cmd>TestLast<cr>")
	vim.keymap.set("n", "<Leader>ts", "<cmd>TestSuite<cr>")
	vim.keymap.set("n", "<Leader>tv", "<cmd>TestVisit<cr>")
	vim.keymap.set("n", "<Leader>tf", "<cmd>TestFile<cr>")
	vim.keymap.set("n", "<Leader>ti", "<cmd>TestInfo<cr>")
	vim.keymap.set("n", "<Leader>te", "<cmd>TestEdit<cr>")
end

return M
