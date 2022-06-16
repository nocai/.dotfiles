return require("plugins.packer").startup(function(use)
	-- commons
	use({ "wbthomason/packer.nvim", opt = true })
	use({
		{ "nvim-lua/plenary.nvim" },
		{ "antoinemadec/FixCursorHold.nvim" }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		{ "nanotee/nvim-lua-guide" },
		{
			"kyazdani42/nvim-web-devicons",
			after = { "nvim-lsp-installer" },
		},
	})

	-- core
	use({
		-- treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			-- cond = function()
			-- 	return nvim.is_not_vscode
			-- end,
			-- event = { "BufRead", "BufWinEnter", "BufNewFile" },
			after = { "nvim-lsp-installer" },
			config = function()
				require("plugins.configs.treesitter")
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			after = { "nvim-treesitter", "nvim-lsp-installer" },
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = { "nvim-treesitter", "nvim-lsp-installer" },
		},
		{
			"p00f/nvim-ts-rainbow",
			after = { "nvim-treesitter" },
		},
		{
			"windwp/nvim-ts-autotag",
			after = { "nvim-treesitter", "nvim-lsp-installer" },
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},

		-- lsp
		{
			"williamboman/nvim-lsp-installer",
			opt = true,
			setup = function()
				nvim.lazy_load({
					events = { "BufRead", "BufWinEnter", "BufNewFile" },
					-- events = { "VimEnter" },
					augroup_name = "NvimLspInstaller_LazyLoad",
					plugins = "nvim-lsp-installer",
					condition = function()
						local file = vim.fn.expand("%")
						return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
					end,
				})
			end,
		},
		{
			"neovim/nvim-lspconfig",
			cond = function()
				return nvim.is_not_vscode
			end,
			after = "nvim-lsp-installer",
			module = "lspconfig",
			config = function()
				require("plugins.configs.misc").nvim_lsp_installer()
				require("plugins.configs.lsp")
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
			after = "nvim-lsp-installer",
			config = function()
				require("plugins.configs.misc").null_ls()
			end,
		},

		-- cmp
		{
			"rafamadriz/friendly-snippets",
			after = "nvim-lsp-installer",
		},
		{
			"L3MON4D3/LuaSnip",
			after = { "friendly-snippets" },
			config = function()
				require("luasnip.config").setup({
					region_check_events = "InsertEnter",
				})
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
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

		-- telescope
		{
			"nvim-telescope/telescope.nvim",
			after = { "nvim-lsp-installer" },
			config = function()
				require("plugins.configs.telescope")
			end,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			after = { "telescope.nvim" },
			run = "make",
			config = function()
				require("telescope").setup({
					extensions = {
						fzf = {
							fuzzy = true, -- false will only do exact matching
							override_generic_sorter = true, -- override the generic sorter
							override_file_sorter = true, -- override the file sorter
							case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						},
					},
				})
				require("telescope").load_extension("fzf")
			end,
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
			after = { "telescope.nvim" },
			config = function()
				require("telescope").setup({
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown({}),
						},
					},
				})
				require("telescope").load_extension("ui-select")
			end,
		},

		-- colorscheme
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
			after = "nvim-web-devicons",
			config = function()
				require("plugins.configs.misc").nvim_tree()
			end,
		},
		{
			"hoob3rt/lualine.nvim",
			after = { "tokyonight.nvim" },
			config = function()
				require("plugins.configs.misc").lualine()
			end,
		},
	})

	-- misc
	use({
		{
			"simrat39/symbols-outline.nvim",
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
			disable = true,
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
			opt = true,
			setup = function()
				vim.g.indent_blankline_char = "┊"
				vim.g.indent_blankline_show_first_indent_level = false

				nvim.lazy_load({
					disable = nvim.is_vscode,
					events = { "BufRead", "BufWinEnter", "BufNewFile" },
					augroup_name = "BeLazyOnFileOpen",
					plugins = "indent-blankline.nvim",

					condition = function()
						local file = vim.fn.expand("%")
						return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
					end,
				})
			end,
			config = function()
				require("plugins.configs.misc").indent_blankline()
			end,
		},
		{
			"chentoast/marks.nvim",
			disable = true,
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
			keys = { "sa", "sd", "sdb", "sr", "srb" },
			setup = function()
				vim.g.textobj_sandwich_no_default_key_mappings = 1
				vim.g.loaded_textobj_sandwich = 1
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
			disable = true,
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
			-- cond = function()
			-- 	return not vim.g.vscode
			-- end,
			opt = true,
			setup = function()
				vim.api.nvim_create_autocmd({ "BufRead" }, {
					callback = function()
						local function onexit(code, _)
							if code == 0 then
								vim.schedule(function()
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
