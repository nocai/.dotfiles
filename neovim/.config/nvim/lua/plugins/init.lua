return require("plugins.packer").startup(function(use)
	-- commons
	use({
		"nanotee/nvim-lua-guide",
		opt = true,
		setup = function()
			nvim.lazy_load({
				disable = nvim.is_vscode,
				events = { "BufRead", "BufWinEnter", "BufNewFile" },
				plugins = "nvim-lua-guide",
			})
		end,
	})
	use({
		{ "wbthomason/packer.nvim", opt = true },
		{ "nvim-lua/plenary.nvim", module = "plenary" },
		{ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
		{ "antoinemadec/FixCursorHold.nvim", after = { "nvim-lua-guide" } }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
	})

	-- core
	use({
		-- treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			module = "nvim-treesitter",
			cmd = {
				"TSInstall",
				"TSBufEnable",
				"TSBufDisable",
				"TSEnable",
				"TSDisable",
				"TSModuleInfo",
			},
			event = "VimEnter",
			config = function()
				require("plugins.configs.treesitter")
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			after = { "nvim-treesitter", "nvim-lua-guide" },
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = { "nvim-treesitter", "nvim-lua-guide" },
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
			cond = function()
				return nvim.is_not_vscode
			end,
			after = "nvim-lua-guide",
			-- module = "lspconfig",
			config = function()
				require("plugins.configs.lsp").lsp()
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			disable = true,
			after = { "nvim-lspconfig" },
			config = function()
				require("lsp_signature").setup({
					bind = true,
					floating_window = true,
					hint_enable = false,
					floating_window_above_cur_line = true,
					timer_interval = 1000,
					handler_opts = {
						border = "rounded", -- double, single, shadow, none
					},
				})
			end,
		},
		{
			-- config, see: ftplugin/java.lua
			"mfussenegger/nvim-jdtls",
			ft = "java",
			after = { "nvim-lspconfig" },
			cond = function()
				return not vim.g.vscode
			end,
		},

		-- null-ls
		{
			"jose-elias-alvarez/null-ls.nvim",
			after = "nvim-lua-guide",
			config = function()
				require("plugins.configs.lsp").null_ls()
			end,
			-- requires = { "ThePrimeagen/refactoring.nvim", after = "null-ls.nvim" },
		},

		-- cmp
		{
			"rafamadriz/friendly-snippets",
			after = "nvim-lua-guide",
		},
		{
			"L3MON4D3/LuaSnip",
			after = { "friendly-snippets" },
			config = function()
				require("luasnip.config").set_config({
					region_check_events = "InsertEnter",
				})
				-- vim.api.nvim_create_autocmd("InsertLeave", {
				-- 	callback = function()
				-- 		if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
				-- 				and not require("luasnip").session.jump_active
				-- 		then
				-- 			require("luasnip").unlink_current()
				-- 		end
				-- 	end,
				-- })
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
					after = "nvim-cmp",
				},
				{
					"hrsh7th/cmp-path",
					after = "nvim-cmp",
				},
				{
					"hrsh7th/cmp-nvim-lsp",
					-- module = "cmp_nvim_lsp",
					after = "nvim-cmp",
				},
				-- {
				-- 	"hrsh7th/cmp-nvim-lua",
				-- 	after = "nvim-cmp",
				-- },
				{
					"saadparwaiz1/cmp_luasnip",
					after = "nvim-cmp",
				},
				-- {
				-- 	"hrsh7th/cmp-cmdline",
				-- 	after = "nvim-cmp",
				-- },
			},
		},
		{
			"windwp/nvim-autopairs",
			after = { "nvim-cmp", "nvim-treesitter" },
			config = function()
				require("plugins.configs.cmp").nvim_autopairs()
			end,
		},
		{
			"abecodes/tabout.nvim",
			after = { "nvim-cmp", "nvim-treesitter" },
			config = function()
				require("tabout").setup({
					tabouts = {
						{ open = "'", close = "'" },
						{ open = '"', close = '"' },
						{ open = "`", close = "`" },
						{ open = "(", close = ")" },
						{ open = "[", close = "]" },
						{ open = "{", close = "}" },
						{ open = "<", close = ">" },
					},
				})
			end,
		},

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
			after = { "telescope.nvim" },
			config = function()
				require("plugins.configs.telescope").project()
			end,
		},

		{
			"folke/tokyonight.nvim",
			after = "nvim-treesitter",
			setup = function()
				-- storm/night/day
				vim.g.tokyonight_style = "storm"

				vim.g.tokyonight_italic_comments = true
				vim.g.tokyonight_italic_keywords = true
				vim.g.tokyonight_italic_functions = false
				vim.g.tokyonight_italic_variables = false
				vim.g.tokyonight_lualine_bold = true

				vim.g.tokyonight_transparent = true
				vim.g.tokyonight_transparent_sidebar = true
				vim.g.tokyonight_dark_float = true

				vim.g.tokyonight_hide_inactive_statusline = true
				vim.g.tokyonight_terminal_colors = true

				-- , bg_statusline = "none"
				vim.g.tokyonight_colors = { bg_float = "none", border = "border_highlight" }
			end,
			config = function()
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
					-- for example, context is off by default, use this to turn it on
					show_current_context = true,
					-- show_current_context_start = true,
				})
			end,
		},
		{
			"numToStr/Comment.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			keys = { { "n", "gc" }, { "n", "gb" }, { "v", "gc" }, { "v", "gb" } },
			config = function()
				require("Comment").setup()
			end,
		},
		{
			"goolord/alpha-nvim",
			disable = true,
			cond = function()
				return nvim.is_not_vscode
			end,
			event = { "VimEnter" },
			config = function()
				require("plugins.configs.misc").alpha_nvim()
				vim.defer_fn(function()
					---@diagnostic disable-next-line: different-requires
					require("packer").loader("nvim-lua-guide")
				end, 100)
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
			opt = true,
			setup = nvim.lazy_load({
				events = { "VimEnter" },
				plugins = "nvim-surround",
			}),
			config = function()
				require("nvim-surround").setup()
			end,
		},
	})

	-- misc
	use({
		{
			"akinsho/toggleterm.nvim",
			cond = function()
				return not vim.g.vscode
			end,
			keys = { [[<C-Space>]], "<Leader>gg" },
			cmd = { "Glow", "Lazygit" },
			config = function()
				require("plugins.configs.misc").toggleterm()
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			opt = true,
			setup = function()
				if nvim.is_vscode then
					return
				end

				vim.api.nvim_create_autocmd({ "BufRead" }, {
					callback = function()
						local function onexit(code, _)
							if code == 0 then
								vim.schedule(function()
									---@diagnostic disable-next-line: different-requires
									require("packer").loader("gitsigns.nvim")
								end)
							end
						end

						local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
						if lines ~= { "" } then
							vim.loop.spawn("git", {
								args = {
									"ls-files",
									"--error-unmatch",
									vim.fn.expand("%:p:h"),
								},
							}, onexit)
						end
					end,
				})
			end,
			config = function()
				require("plugins.configs.misc").gitsigns()
			end,
		},
		{
			"simrat39/symbols-outline.nvim",
			-- disable = true,
			after = { "nvim-lspconfig" },
			setup = function()
				require("plugins.configs.misc").symbols_outline()
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
			"rcarriga/nvim-notify",
			disable = true,
			after = { "telescope.nvim" },
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
			"chentoast/marks.nvim",
			keys = { { "n", "m" } },
			cond = function()
				return nvim.is_not_vscode
			end,
			config = function()
				require("plugins.configs.misc").marks()
			end,
		},
		{
			"luukvbaal/stabilize.nvim",
			disable = true,
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
			"thinca/vim-quickrun",
			disable = true,
			cond = function()
				return not vim.g.vscode
			end,
			keys = { "<Leader>r" },
			config = function()
				require("plugins.configs.misc").vim_quickrun()
			end,
		},
		{
			"vim-test/vim-test",
			disable = true,
			cond = function()
				return not vim.g.vscode
			end,
			keys = { "<Leader>t" },
			config = function()
				require("plugins.configs.misc").vim_test()
			end,
		},
		{
			"klen/nvim-test",
			keys = { "<Leader>t" },
			config = function()
				require("plugins.configs.misc").nvim_test()
			end,
		},
		{
			"sebdah/vim-delve",
			cond = function()
				return not vim.g.vscode
			end,
			ft = { "go" },
		},
	})
end)
