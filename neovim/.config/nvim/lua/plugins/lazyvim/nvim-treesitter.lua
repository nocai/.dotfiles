return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- disable default keys
		keys = function()
			return {}
		end,
		opts = {
			ensure_installed = {
				"lua"
			},
			highlight = {
				enable = not vim.g.vscode,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = false,
			},
			textobjects = {
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["ia"] = "@parameter.inner",
						["aa"] = "@parameter.outer",
						["if"] = "@function.inner",
						["af"] = "@function.outer",
						["ic"] = "@class.inner",
						["ac"] = "@class.outer",
						["as"] = { query = "@scope", query_group = "locals" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]a"] = "@parameter.outer",
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]]"] = "@class.outer",
						["]s"] = { query = "@scope", query_group = "locals" },
					},
					goto_next_end = {
						["]A"] = "@parameter.outer",
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]["] = "@class.outer",
						["]S"] = { query = "@scope", query_group = "locals" },
					},
					goto_previous_start = {
						["[a"] = "@parameter.outer",
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[["] = "@class.outer",
						["[s"] = { query = "@scope", query_group = "locals" },
					},
					goto_previous_end = {
						["[A"] = "@parameter.outer",
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[]"] = "@class.outer",
						["[S"] = { query = "@scope", query_group = "locals" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>sa"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>sA"] = "@parameter.inner",
					},
				},
				lsp_interop = {
					enable = not vim.g.vscode,
					border = "rounded",
					peek_definition_code = {
						["<leader>pf"] = "@function.outer",
						["<leader>pc"] = "@class.outer",
					},
				},
			}
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			-- I want to use Git instead of curl for downloading the parsers
			require("nvim-treesitter.install").prefer_git = true
			-- I want to use a mirror instead of "https://github.com/"
			for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
				config.install_info.url = ivim.git_proxy_prefix .. config.install_info.url
			end

			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
		end,
		dependencies = {
			{
				"p00f/nvim-ts-rainbow",
				enabled = not vim.g.vscode,
				config = function()
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
		}
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
				},
			})
		end
	},
}
