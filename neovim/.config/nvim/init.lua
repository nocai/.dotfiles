local present, impatient = pcall(require, "impatient")
if present then
	impatient.enable_profile()
end

require("nvim")
require("option")
require("autocmd")

return require("configs.packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({
		{ "lewis6991/impatient.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "antoinemadec/FixCursorHold.nvim" }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		{
			"nanotee/nvim-lua-guide",
			cond = function()
				return nvim.is_not_vscode
			end,
		},
		{
			"kyazdani42/nvim-web-devicons",
			cond = function()
				return nvim.is_not_vscode
			end,
		},

		-- colorscheme
		{
			"sainnhe/sonokai",
			disable = true,
			cond = function()
				return nvim.is_not_vscode
			end,
			setup = function()
				require("configs.ui").sonokai()
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
				require("configs.ui").tokyonight()
			end,
			config = function()
				vim.cmd([[colorscheme tokyonight]])
			end,
		},
	})

	-- UI
	use({
		{
			"kyazdani42/nvim-tree.lua",
			cond = function()
				return nvim.is_not_vscode
			end,
			after = { "nvim-web-devicons" },
			config = function()
				require("configs.ui").nvim_tree()
			end,
		},
		{
			"hoob3rt/lualine.nvim",
			cond = function()
				return not nvim.is_vscode
			end,
			after = { "nvim-web-devicons" },
			config = function()
				require("configs.ui").lualine()
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
				require("configs.ui").nvim_bufferline()
			end,
		},
		{
			"stevearc/dressing.nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			event = "BufRead",
			config = function()
				require("configs.ui").dressing()
			end,
		},
		{
			"goolord/alpha-nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			config = function()
				require("configs.ui").alpha_nvim()
			end,
		},
		{
			"rcarriga/nvim-notify",
			cond = function()
				return nvim.is_not_vscode
			end,
			requires = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("configs.ui").notify()
			end,
		},
	})

	-- misc
	use({
		{
			"tweekmonster/startuptime.vim",
			cond = function()
				return not nvim.is_vscode
			end,
			cmd = { "StartupTime" },
		},
		{
			"voldikss/vim-translator",
			cond = function()
				return not nvim.is_vscode
			end,
			keys = { "<leader>tr" },
			setup = function()
				vim.g.translator_default_engines = { "youdao", "bing" }
				vim.keymap.set({ "n", "x" }, "<leader>tr", ":TranslateW<CR>")
			end,
		},
		{
			"karb94/neoscroll.nvim",
			disable = true,
			cond = function()
				return not vim.g.vscode
			end,
			event = "WinScrolled",
			config = function()
				require("configs.misc").neoscroll()
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
				require("configs.misc").toggleterm()
			end,
		},
		{
			"rhysd/accelerated-jk",
			disable = true,
			event = { "CursorMoved" },
			config = function()
				vim.keymap.set("n", "n", "<Plug>(accelerated_jk_gj)", { silent = true })
				vim.keymap.set("n", "e", "<Plug>(accelerated_jk_gk)", { silent = true })
			end,
		},
		{
			"norcalli/nvim-colorizer.lua",
			cond = function()
				return not vim.g.vscode
			end,
			event = "BufRead",
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
			event = "BufRead",
			setup = function()
				vim.g.indent_blankline_char = "┊"
				vim.g.indent_blankline_show_first_indent_level = false
			end,
			config = function()
				require("configs.misc").indent_blankline()
			end,
		},
		{
			"chentoast/marks.nvim",
			event = "BufReadPost",
			cond = function()
				return nvim.is_not_vscode
			end,
			config = function()
				require("configs.misc").marks()
			end,
		},
		{
			"machakann/vim-sandwich",
			setup = function()
				vim.g.textobj_sandwich_no_default_key_mappings = 1
			end,
			keys = { "sa", "sr", "sd" },
			config = function()
				require("configs.misc").vim_sandwich()
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
			event = "BufReadPost",
			config = function()
				require("todo-comments").setup()
			end,
		},
		{
			"ggandor/lightspeed.nvim",
			disable = true,
			event = "BufRead",
			cond = function()
				return not vim.g.vscode
			end,
		},
		{
			"junegunn/vim-easy-align",
			keys = { "<leader>ga" },
			config = function()
				vim.keymap.set({ "n", "x" }, "<Leader>ga", "<Plug>(EasyAlign)")
			end,
		},
	})

	-- textobject
	use({
		"kana/vim-textobj-user",
		disable = true,
		event = { "BufRead" },
		requires = {
			{
				"kana/vim-textobj-indent",
				setup = function()
					vim.g.textobj_indent_no_default_key_mappings = 1
				end,
				keys = { "li", "lI", "ai", "aI" },
				config = function()
					require("configs.misc").vim_textobj_indent()
				end,
			},
			{
				"sgur/vim-textobj-parameter",
				keys = { "la", "aa" },
				setup = function()
					vim.g.textobj_parameter_no_default_key_mappings = 1
				end,
				config = function()
					require("configs.misc").vim_textobj_parameter()
				end,
			},
		},
	})

	-- tools
	use({
		{
			"lewis6991/gitsigns.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			event = { "BufRead" },
			config = function()
				require("configs.tools").gitsigns()
			end,
		},
		{
			"thinca/vim-quickrun",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go", "rust", "python" },
			config = function()
				require("configs.tools").vim_quickrun()
			end,
		},
		{
			"vim-test/vim-test",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go", "rust", "java" },
			config = function()
				require("configs.tools").vim_test()
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

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		cond = function()
			return nvim.is_not_vscode
		end,
		event = { "VimEnter" },
		config = function()
			require("configs.telescope")
		end,
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				cond = function()
					return nvim.is_not_vscode
				end,
				run = "make",
			},
			{
				"ahmedkhalf/project.nvim",
				cond = function()
					return nvim.is_not_vscode
				end,
				config = function()
					require("project_nvim").setup()
				end,
			},
		},
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		cond = function()
			return not vim.g.vscode
		end,
		event = { "BufRead", "BufNewFile" },
		run = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
		requires = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				event = "BufReadPost",
				cond = function()
					return nvim.is_not_vscode
				end,
			},
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "BufReadPost",
				cond = function()
					return nvim.is_not_vscode
				end,
			},
			{
				"p00f/nvim-ts-rainbow",
				event = "BufReadPost",
				cond = function()
					return nvim.is_not_vscode
				end,
			},
			{
				"windwp/nvim-ts-autotag",
				event = "BufReadPost",
				cond = function()
					return nvim.is_not_vscode
				end,
			},
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				event = "BufReadPost",
				cond = function()
					return nvim.is_not_vscode
				end,
			},
		},
	})

	-- lsp
	use({
		{
			"neovim/nvim-lspconfig",
			cond = function()
				return nvim.is_not_vscode
			end,
			event = "BufRead",
			config = function()
				require("configs.lsp")
			end,
		},
		{
			"williamboman/nvim-lsp-installer",
			cond = function()
				return nvim.is_not_vscode
			end,
			cmd = { "LspInstall", "LspInstallInfo", "LspInstallLog" },
			config = function()
				require("configs.lsp").nvim_lsp_installer()
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			cond = function()
				return nvim.is_not_vscode
			end,
			ft = { "lua" },
			config = function()
				require("configs.lsp").null_ls()
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			after = { "nvim-lspconfig" },
			config = function()
				require("configs.lsp").lsp_signature()
			end,
		},
		{
			"simrat39/symbols-outline.nvim",
			after = { "nvim-lspconfig" },
			setup = function()
				require("configs.lsp").symbols_outline()
			end,
		},
		{
			-- config, see: ftplugin/java.lua
			"mfussenegger/nvim-jdtls",
			ft = { "java" },
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
				return not vim.g.vscode
			end,
			event = "InsertEnter",
			config = function()
				require("configs.cmp").nvim_cmp()
			end,
			requires = {
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
				},
				{
					"hrsh7th/cmp-buffer",
					after = "nvim-cmp",
					config = function()
						require("configs.cmp").cmp_buffer()
					end,
				},
			},
		},
		{
			"L3MON4D3/LuaSnip",
			after = "nvim-cmp",
			config = function()
				require("luasnip.loaders.from_vscode").load()
				require("configs.cmp").luasnip()
			end,
			requires = {
				"rafamadriz/friendly-snippets",
				after = { "nvim-cmp" },
			},
		},
		{
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("configs.cmp").nvim_autopairs()
			end,
		},
		{
			"abecodes/tabout.nvim",
			wants = { "nvim-treesitter" }, -- or require if not used so far
			after = "nvim-cmp",
			config = function()
				require("configs.cmp").tabout()
			end,
		},
	})
end)
