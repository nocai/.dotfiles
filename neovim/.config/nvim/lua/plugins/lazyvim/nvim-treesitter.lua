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
					},
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true of false
					include_surrounding_whitespace = true,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]a"] = "@parameter.outer",
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]A"] = "@parameter.outer",
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[a"] = "@parameter.outer",
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[A"] = "@parameter.outer",
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[]"] = "@class.outer",
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
		end
	}
}
