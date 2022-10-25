return require("plugins.packer").startup(function(use)
	-- commons
	use({
		{
			"wbthomason/packer.nvim",
			cmd = {
				"PackerSnapshot",
				"PackerSnapshotRollback",
				"PackerSnapshotDelete",
				"PackerInstall",
				"PackerUpdate",
				"PackerSync",
				"PackerClean",
				"PackerCompile",
				"PackerStatus",
				"PackerProfile",
				"PackerLoad",
			},
		},
		{ "nvim-lua/plenary.nvim", module = "plenary" },
		{ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
		{
			"nanotee/nvim-lua-guide",
			opt = true,
			setup = function()
				local augroup = "LazyLoad:" .. vim.fn.rand()
				vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
					group = vim.api.nvim_create_augroup(augroup, {}),
					callback = function()
						vim.api.nvim_del_augroup_by_name(augroup)
						vim.defer_fn(function()
							---@diagnostic disable-next-line: different-requires
							require("packer").loader("nvim-lua-guide")
						end, 0)
					end,
				})
			end,
		},
		{
			"antoinemadec/FixCursorHold.nvim",
			after = { "nvim-lua-guide" },
		}, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		{
			"lewis6991/impatient.nvim",
		},
	})

	-- core
	use({
		--
		-- treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			cmd = {
				"TSInstall",
				"TSBufEnable",
				"TSBufDisable",
				"TSEnable",
				"TSDisable",
				"TSModuleInfo",
			},
			run = ":TSUpdate",
			event = "VimEnter",
			module = "nvim-treesitter",
			config = function()
				require("plugins.configs.treesitter")
			end,
		},
		-- {
		-- 	"nvim-treesitter/nvim-treesitter-context",
		-- 	after = { "nvim-treesitter", "nvim-lua-guide" },
		-- },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = { "nvim-treesitter", "nvim-lua-guide" },
			config = function()
				require("plugins.configs.treesitter").nvim_treesitter_textobjects()
			end,
		},
		{
			"p00f/nvim-ts-rainbow",
			after = { "nvim-treesitter" },
			config = function()
				require("plugins.configs.treesitter").nvim_ts_rainbow()
			end,
		},
		{
			"windwp/nvim-ts-autotag",
			after = { "nvim-treesitter", "nvim-lua-guide" },
			config = function()
				require("plugins.configs.treesitter").nvim_ts_autotag()
			end,
		},

		--
		-- lsp
		{
			"williamboman/mason.nvim",
			cmd = {
				"Mason",
				"MasonInstall",
				"MasonInstallAll",
				"MasonUninstall",
				"MasonUninstallAll",
				"MasonLog",
			},
			config = function()
				require("plugins.configs.lsp").mason()
			end,
		},
		{
			"neovim/nvim-lspconfig",
			after = "nvim-lua-guide",
			config = function()
				require("plugins.configs.lsp").lsp()
			end,
		},
		-- {
		-- 	"ray-x/lsp_signature.nvim",
		-- 	after = { "nvim-lspconfig" },
		-- 	config = function()
		-- 		require("lsp_signature").setup({
		-- 			bind = true,
		-- 			floating_window = true,
		-- 			hint_enable = false,
		-- 			floating_window_above_cur_line = true,
		-- 			timer_interval = 1000,
		-- 			handler_opts = {
		-- 				border = "rounded", -- double, single, shadow, none
		-- 			},
		-- 		})
		-- 	end,
		-- },
		{
			-- config, see: ftplugin/java.lua
			"mfussenegger/nvim-jdtls",
			ft = "java",
			after = { "nvim-lspconfig" },
			cond = function()
				return not vim.g.vscode
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			after = { "nvim-lua-guide" },
			config = function()
				require("plugins.configs.lsp").null_ls()
			end,
		},

		--
		-- cmp
		{
			"rafamadriz/friendly-snippets",
			after = { "nvim-lua-guide" },
		},
		{
			"L3MON4D3/LuaSnip",
			after = { "friendly-snippets" },
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			-- module = "cmp",
			event = "InsertEnter",
			config = function()
				require("plugins.configs.cmp")
			end,
			requires = {
				{
					"hrsh7th/cmp-buffer",
					after = { "nvim-cmp" },
				},
				{
					"hrsh7th/cmp-path",
					after = { "nvim-cmp" },
				},
				{
					"hrsh7th/cmp-nvim-lsp",
					after = { "nvim-cmp" },
				},
				{
					"saadparwaiz1/cmp_luasnip",
					after = { "nvim-cmp" },
				},
				-- {
				-- 	"hrsh7th/cmp-nvim-lua",
				-- 	after = {"nvim-cmp"},
				-- },
				-- {
				-- 	"hrsh7th/cmp-cmdline",
				-- 	after = {"nvim-cmp"},
				-- },
			},
		},
		{
			"windwp/nvim-autopairs",
			after = { "nvim-cmp" },
			config = function()
				require("plugins.configs.cmp").nvim_autopairs()
			end,
		},
		{
			"abecodes/tabout.nvim",
			wants = { "nvim-treesitter" }, -- or require if not used so far
			after = { "nvim-cmp" },
			config = function()
				require("tabout").setup({})
			end,
		},

		--
		-- telescope
		{
			"nvim-telescope/telescope.nvim",
			after = { "nvim-lua-guide" },
			cmd = "Telescope",
			config = function()
				require("plugins.configs.telescope")
			end,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			after = { "telescope.nvim" },
			run = "make",
			config = function()
				require("plugins.configs.telescope").telescope_fzf_native()
			end,
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
			after = { "telescope.nvim" },
			config = function()
				require("plugins.configs.telescope").telescope_ui_select()
			end,
		},
		{
			"ahmedkhalf/project.nvim",
			disable = true,
			after = { "telescope.nvim" },
			config = function()
				require("plugins.configs.telescope").project()
			end,
		},

		--
		-- others
		{
			"folke/tokyonight.nvim",
			after = { "nvim-treesitter" },
			config = function()
				require("tokyonight").setup({
					-- style = "moon", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
					transparent = true,
					styles = {
						-- Background styles. Can be "dark", "transparent" or "normal"
						sidebars = "transparent", -- style for sidebars, see below
						floats = "transparent", -- style for floating windows
					},
				})
				vim.cmd([[colorscheme tokyonight]])
			end,
		},
		{
			"kyazdani42/nvim-tree.lua",
			after = { "nvim-web-devicons" },
			config = function()
				require("plugins.configs.nvim_tree")
			end,
		},
		{
			"hoob3rt/lualine.nvim",
			after = { "tokyonight.nvim" },
			config = function()
				require("plugins.configs.lualine")
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			after = { "nvim-lua-guide" },
			setup = function()
				vim.g.indent_blankline_char = "┊"
				vim.g.indent_blankline_show_first_indent_level = false
			end,
			config = function()
				require("indent_blankline").setup({
					show_current_context = true,
					-- show_current_context_start = true,
				})
			end,
		},
		{
			"numToStr/Comment.nvim",
			keys = { { "n", "gc" }, { "n", "gb" }, { "v", "gc" }, { "v", "gb" } },
			config = function()
				require("Comment").setup()
			end,
		},
		{
			"norcalli/nvim-colorizer.lua",
			after = { "nvim-lua-guide" },
			config = function()
				require("colorizer").setup()
			end,
		},
		-- {
		-- 	"machakann/vim-sandwich",
		-- 	opt = true,
		-- 	setup = nvim.lazy_load({
		-- 		events = { "VimEnter" },
		-- 		plugins = "vim-sandwich",
		-- 		setup = function()
		-- 			vim.g.textobj_sandwich_no_default_key_mappings = 1
		-- 		end,
		-- 	}),
		-- },
		{
			"kylechui/nvim-surround",
			after = { "nvim-lua-guide" },
			config = function()
				require("nvim-surround").setup()
			end,
		},
	})

	-- misc
	use({
		{
			"akinsho/toggleterm.nvim",
			keys = { [[<C-Space>]], "<Leader>gg", [[<C-\>]] },
			cmd = { "Glow", "Lazygit", "TermExec" },
			module = "toggleterm", -- depend by nvim-test
			config = function()
				require("plugins.configs.misc").toggleterm()
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			after = { "nvim-lua-guide" },
			config = function()
				require("plugins.configs.misc").gitsigns()
			end,
		},
		{
			"tweekmonster/startuptime.vim",
			cmd = { "StartupTime" },
		},
		{
			"chentoast/marks.nvim",
			disable = true,
			keys = { { "n", "m" } },
			config = function()
				require("plugins.configs.misc").marks()
			end,
		},
		{
			"famiu/bufdelete.nvim",
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
			keys = { "<C-k>t", "<C-k><C-t>" },
			cmd = { "TodoLocList", "TodoQuickList", "TodoQuickFix", "TodoTelescope", "TodoTrouble" },
			config = function()
				require("todo-comments").setup({
					highlight = {
						before = "",
						after = "",
						keyword = "",
					},
				})
				vim.keymap.set("n", "<C-k>t", [[<cmd>TodoTelescope<CR>]])
				vim.keymap.set("n", "<C-k><C-t>", [[<cmd>TodoTelescope<CR>]])
			end,
		},
		{
			"junegunn/vim-easy-align",
			keys = { "<leader>ea" },
			config = function()
				vim.keymap.set({ "n", "x" }, "<Leader>ea", "<Plug>(EasyAlign)")
			end,
		},

		{
			"thinca/vim-quickrun",
			keys = { "<Leader>r" },
			config = function()
				require("plugins.configs.misc").vim_quickrun()
			end,
		},
		{
			"vim-test/vim-test",
			keys = { "<Leader>t" },
			config = function()
				require("plugins.configs.misc").vim_test()
			end,
		},
		-- {
		-- 	"klen/nvim-test",
		-- 	keys = { "<Leader>t" },
		-- 	config = function()
		-- 		require("plugins.configs.misc").nvim_test()
		-- 	end,
		-- },
		{
			"sebdah/vim-delve",
			ft = { "go" },
		},
	})
end)
