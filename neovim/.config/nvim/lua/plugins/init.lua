return {
	-- commons
	{
		{ "nanotee/nvim-lua-guide" },
		-- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		{ "antoinemadec/FixCursorHold.nvim", event = { "CursorHold" } },
		{
			"EdenEast/nightfox.nvim",
			enabled = not vim.g.vscode,
			opts = {
				options = {
					transparent = true,
					styles = {
						comments = "italic",
						functions = "italic,bold",
					},
				},
			}
		},
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
		"kylechui/nvim-surround",
		event = { "VeryLazy" },
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "<leader>cF", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Vim easy align" },
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
	{
		"vim-test/vim-test",
		enabled = not vim.g.vscode,
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
	{
		"windwp/nvim-ts-autotag",
		enabled = not vim.g.vscode,
		ft = {
			"html",
			"xml",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
					filetypes = { "html", "xml" },
				},
			})
		end
	},
	{
		"p00f/nvim-ts-rainbow",
		enabled = not vim.g.vscode,
		event = { "VeryLazy" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local util = require("lazyvim.util")
			local opts = util.opts("nvim-lspconfig")
			print(vim.inspect(opts))
			require("nvim-treesitter.configs").setup({
				rainbow = {
					enable = true,
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
		end
	},
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
