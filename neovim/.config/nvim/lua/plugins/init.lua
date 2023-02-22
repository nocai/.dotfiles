return {
	-- commons
	{
		{ "nanotee/nvim-lua-guide",          event = "VeryLazy" },
		-- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		{ "antoinemadec/FixCursorHold.nvim", event = { "CursorHold" } },
	},

	-- util
	{
		"sindrets/diffview.nvim",
		enabled = not vim.g.vscode,
		cmd = {
			"DiffviewClose",
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewLog",
		},
	},
	{
		"thinca/vim-quickrun",
		enabled = not vim.g.vscode,
		keys = {
			{ "<leader>rr", "<Plug>(quickrun)", desc = "Code runner" },
		},
		init = function()
			vim.g.quickrun_no_default_key_mappings = 1
			vim.g.quickrun_config = { _ = { outputter = "message" } }
		end
	},
	-- {
	-- 	"vim-test/vim-test",
	-- 	-- enabled = not vim.g.vscode,
	-- 	enabled = false,
	-- 	keys = {
	-- 		{ "<leader>tt", "<cmd>TestNearest<CR>", desc = "Test nearest" },
	-- 		{ "<leader>tf", "<cmd>TestFile<CR>",    desc = "Test file" },
	-- 		{ "<leader>ts", "<cmd>TestSuite<CR>",   desc = "Test suite" },
	-- 		{ "<leader>tl", "<cmd>TestLast<CR>",    desc = "Test last" },
	-- 		{ "<leader>tv", "<cmd>TestVisit<CR>",   desc = "Test visit" },
	-- 	},
	-- 	config = function()
	-- 		vim.cmd([[let test#strategy = "neovim"]])
	-- 	end,
	-- },

	{
		"akinsho/toggleterm.nvim",
		keys = { [[<C-\>]] },
		enabled = not vim.g.vscode,
		opts = {
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
		}
	}
}
