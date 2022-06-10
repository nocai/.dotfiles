return require("plugins.packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({
		{ "lewis6991/impatient.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "antoinemadec/FixCursorHold.nvim" }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		{ "nanotee/nvim-lua-guide" },
		{
			"kyazdani42/nvim-web-devicons",
			cond = function()
				return nvim.is_not_vscode
			end,
		},
	})

	-- treesitter
	use({
		{
			"nvim-treesitter/nvim-treesitter",
			cond = function()
				return not vim.g.vscode
			end,
			-- event = { "BufRead", "BufNewFile" },
			event = { "VimEnter" },
			run = ":TSUpdate",
			config = function()
				require("plugins.configs.treesitter")
			end,
			requires = {
				{
					"nvim-treesitter/nvim-treesitter-context",
					after = { "nvim-treesitter" },
				},
				{
					"nvim-treesitter/nvim-treesitter-textobjects",
					after = { "nvim-treesitter" },
				},
				{
					"p00f/nvim-ts-rainbow",
					after = { "nvim-treesitter" },
				},
				-- {
				-- 	"JoosepAlviste/nvim-ts-context-commentstring",
				-- 	after = { "nvim-treesitter" },
				-- },
			},
		},
		{
			"SmiteshP/nvim-gps",
			after = { "nvim-treesitter" },
			config = function()
				require("plugins.configs.misc").gps()
			end,
		},
		{
			"windwp/nvim-ts-autotag",
			after = { "nvim-treesitter" },
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},
	})

	-- lsp
	use({
		{
			"neovim/nvim-lspconfig",
			cond = function()
				return nvim.is_not_vscode
			end,
			event = { "VimEnter" },
			config = function()
				require("plugins.configs.lsp")
			end,
		},
		{
			"williamboman/nvim-lsp-installer",
			cond = function()
				return nvim.is_not_vscode
			end,
			cmd = { "LspInstall", "LspInstallInfo", "LspInstallLog" },
			config = function()
				require("plugins.configs.misc").nvim_lsp_installer()
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			event = { "VimEnter" },
			cond = function()
				return nvim.is_not_vscode
			end,
			ft = { "lua" },
			config = function()
				require("plugins.configs.misc").null_ls()
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			disable = true,
			after = { "nvim-lspconfig" },
			cond = function()
				return not vim.g.vscode
			end,
			config = function()
				require("plugins.configs.misc").lsp_signature()
			end,
		},
		{
			"simrat39/symbols-outline.nvim",
			after = { "nvim-lspconfig" },
			cond = function()
				return not vim.g.vscode
			end,
			setup = function()
				require("plugins.configs.misc").symbols_outline()
			end,
		},
		{
			-- config, see: ftplugin/java.lua
			"mfussenegger/nvim-jdtls",
			ft = { "java" },
			after = { "nvim-lspconfig" },
			cond = function()
				return not vim.g.vscode
			end,
		},
	})

	-- cmp
	use({
		{
			"hrsh7th/nvim-cmp",
			cond = function()
				return nvim.is_not_vscode
			end,
			event = "InsertEnter",
			config = function()
				require("plugins.configs.cmp")
			end,
			requires = {
				{
					"hrsh7th/cmp-buffer",
					after = "nvim-cmp",
				},
				{
					"hrsh7th/cmp-nvim-lsp",
					after = "nvim-cmp",
				},
				{
					"hrsh7th/cmp-nvim-lua",
					after = "nvim-cmp",
				},
				{
					"saadparwaiz1/cmp_luasnip",
					after = "nvim-cmp",
					requires = {
						{
							"rafamadriz/friendly-snippets",
							after = "nvim-cmp",
						},
						{
							"L3MON4D3/LuaSnip",
							after = { "friendly-snippets", "nvim-cmp" },
							config = function()
								require("luasnip.config").setup({
									region_check_events = "InsertEnter",
								})
								require("luasnip.loaders.from_vscode").lazy_load()
							end,
						},
					},
				},
			},
		},
		{
			"windwp/nvim-autopairs",
			after = { "nvim-cmp", "nvim-treesitter" },
			config = function()
				require("nvim-autopairs").setup({ check_ts = true })
				require("cmp").event:on(
					"confirm_done",
					require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = "" } })
				)
			end,
		},
		{
			"abecodes/tabout.nvim",
			after = { "nvim-cmp", "nvim-treesitter" },
			config = function()
				require("tabout").setup()
			end,
		},
	})

	-- telescope
	use({
		{
			"nvim-telescope/telescope.nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			event = { "VimEnter" },
			config = function()
				require("plugins.configs.telescope")
			end,
			requires = {
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					cond = function()
						return nvim.is_not_vscode
					end,
					run = "make",
				},
			},
		},
		{
			"ahmedkhalf/project.nvim",
			after = { "telescope.nvim" },
			cond = function()
				return nvim.is_not_vscode
			end,
			config = function()
				require("project_nvim").setup()
			end,
		},
	})

	-- misc
	use({
		-- colorscheme
		{
			"sainnhe/sonokai",
			disable = true,
			cond = function()
				return nvim.is_not_vscode
			end,
			setup = function()
				require("plugins.configs.misc").sonokai()
			end,
			config = function()
				-- vim.cmd([[colorscheme sonokai]])
			end,
		},
		{
			"folke/tokyonight.nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			setup = function()
				require("plugins.configs.misc").tokyonight()
			end,
			config = function()
				vim.cmd([[colorscheme tokyonight]])
			end,
		},
		{
			"kyazdani42/nvim-tree.lua",
			cond = function()
				return nvim.is_not_vscode
			end,
			after = { "nvim-web-devicons" },
			config = function()
				require("plugins.configs.misc").nvim_tree()
			end,
		},
		{
			"hoob3rt/lualine.nvim",
			cond = function()
				return not nvim.is_vscode
			end,
			after = { "nvim-web-devicons" },
			config = function()
				require("plugins.configs.misc").lualine()
			end,
		},
		{
			"akinsho/nvim-bufferline.lua",
			disable = true,
			cond = function()
				return nvim.is_not_vscode
			end,
			after = { "nvim-web-devicons" },
			config = function()
				require("plugins.configs.misc").nvim_bufferline()
			end,
		},
		{
			"stevearc/dressing.nvim",
			disable = true,
			cond = function()
				return nvim.is_not_vscode
			end,
			event = { "VimEnter" },
			config = function()
				require("plugins.configs.misc").dressing()
			end,
		},
		{
			"goolord/alpha-nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			event = { "VimEnter" },
			config = function()
				require("plugins.configs.misc").alpha_nvim()
			end,
		},
		{
			"rcarriga/nvim-notify",
			cond = function()
				return nvim.is_not_vscode
			end,
			requires = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("plugins.configs.misc").notify()
			end,
		},
		{
			"tweekmonster/startuptime.vim",
			cond = function()
				return not nvim.is_vscode
			end,
			cmd = { "StartupTime" },
		},
		{
			"karb94/neoscroll.nvim",
			disable = true,
			cond = function()
				return not vim.g.vscode
			end,
			event = "WinScrolled",
			config = function()
				require("plugins.configs.misc").neoscroll()
			end,
		},
		{
			"akinsho/toggleterm.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			keys = { "<C-\\>", "<Leader>gg" },
			cmd = { "Glow", "Lazygit" },
			config = function()
				require("plugins.configs.misc").toggleterm()
			end,
		},
		{
			"norcalli/nvim-colorizer.lua",
			cond = function()
				return not vim.g.vscode
			end,
			event = { "VimEnter" },
			ft = { "lua", "html", "css" },
			config = function()
				require("colorizer").setup()
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			event = { "VimEnter" },
			setup = function()
				vim.g.indent_blankline_char = "┊"
				vim.g.indent_blankline_show_first_indent_level = false
			end,
			config = function()
				require("plugins.configs.misc").indent_blankline()
			end,
		},
		{
			"chentoast/marks.nvim",
			event = { "VimEnter" },
			cond = function()
				return nvim.is_not_vscode
			end,
			config = function()
				require("plugins.configs.misc").marks()
			end,
		},
		{
			"machakann/vim-sandwich",
			event = { "VimEnter" },
			setup = function()
				vim.g.textobj_sandwich_no_default_key_mappings = 1
				vim.g.loaded_textobj_sandwich = 1
			end,
		},
		{
			"luukvbaal/stabilize.nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			config = function()
				require("stabilize").setup()
			end,
		},
		{
			"famiu/bufdelete.nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			keys = { "<Leader>bd", "<Leader>bw" },
			config = function()
				vim.keymap.set("n", "<Leader>bd", function()
					require("bufdelete").bufdelete(0, true)
				end)
				vim.keymap.set("n", "<Leader>bw", function()
					require("bufdelete").bufwipeout(0)
				end)
			end,
		},
		{
			"folke/todo-comments.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			-- event = { "VimEnter" },
			cmd = { "TodoLocList", "TodoQuickList", "TodoQuickFix", "TodoTelescope", "TodoTrouble" },
			config = function()
				require("todo-comments").setup({
					highlight = {
						before = "",
						after = "",
						keyword = "",
					},
				})
			end,
		},
		{
			"junegunn/vim-easy-align",
			keys = { "<leader>ga" },
			config = function()
				vim.keymap.set({ "n", "x" }, "<Leader>ga", "<Plug>(EasyAlign)")
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			event = { "VimEnter" },
			config = function()
				require("plugins.configs.misc").gitsigns()
			end,
		},
		{
			"thinca/vim-quickrun",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go", "rust", "python" },
			config = function()
				require("plugins.configs.misc").vim_quickrun()
			end,
		},
		{
			"vim-test/vim-test",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go", "rust", "java" },
			config = function()
				require("plugins.configs.misc").vim_test()
			end,
		},
		{
			"sebdah/vim-delve",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go" },
		},
		{
			"numToStr/Comment.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			keys = { "gc", "gb" },
			config = function()
				require("Comment").setup()
			end,
		},
	})
end)
