return {
	-- commons
	{
		{ "nanotee/nvim-lua-guide" },
		-- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		{ "antoinemadec/FixCursorHold.nvim", event = { "CursorHold" } },
	},

	-- util
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "<leader>gq", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Vim easy align" },
		}
	},
	{
		"thinca/vim-quickrun",
		keys = {
			{ "<leader>rr", "<Plug>(quickrun)", desc = "Code runner" },
		},
		init = function()
			vim.g.quickrun_no_default_key_mappings = 1
			vim.g.quickrun_config = { _ = { outputter = "message" } }
		end
	},
	{
		"vim-test/vim-test",
		keys = {
			{ "<leader>tt", "<cmd>TestNearest<CR>", desc = "Test nearest" },
			{ "<leader>tf", "<cmd>TestFile<CR>",    desc = "Test file" },
			{ "<leader>ts", "<cmd>TestSuite<CR>",   desc = "Test suite" },
			{ "<leader>tl", "<cmd>TestLast<CR>",    desc = "Test last" },
			{ "<leader>tv", "<cmd>TestVisit<CR>",   desc = "Test visit" },
		},
		config = function()
			vim.cmd([[let test#strategy = "neovim"]])
		end,
	},
}
