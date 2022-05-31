local treesitter = {}

function treesitter.nvim_treesitter()
	-- I want to use Git instead of curl for downloading the parsers
	require("nvim-treesitter.install").prefer_git = true
	-- I want to use a mirror instead of "https://github.com/"
	for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
		config.install_info.url = config.install_info.url:gsub(
			"https://github.com/",
			"https://ghproxy.com/https://github.com/"
		)
	end
	-- :TSInstall
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "lua", "go" },
		highlight = { enable = true, additional_vim_regex_highlighting = false, use_languagetree = true },
		-- indent = { enable = true },
		incremental_selection = {
			enable = false,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
	})
	vim.api.nvim_command("set foldmethod=expr")
	vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
end

function treesitter.nvim_treesitter_textobjects()
	require("nvim-treesitter.configs").setup({
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["lf"] = "@function.inner",
					["af"] = "@function.outer",
					["lc"] = "@class.inner",
					["ac"] = "@class.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]f"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["san"] = "@parameter.inner",
				},
				swap_previous = {
					["sap"] = "@parameter.inner",
				},
			},
			lsp_interop = {
				enable = true,
				border = "none",
				peek_definition_code = {
					["gpf"] = "@function.outer",
					["gpc"] = "@class.outer",
				},
			},
		},
	})
end

function treesitter.nvim_ts_tainbow()
	local present, configs = pcall(require, "nvim-treesitter.configs")
	if present then
		configs.setup({
			rainbow = {
				enable = true,
				-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
				-- colors = {}, -- table of hex strings
				-- termcolors = {} -- table of colour name strings
			},
		})
	end
end

function treesitter.vim_matchup()
	pcall(vim.cmd, [[unmap i%]])
	-- vim.keymap.del({ "x", "o" }, "i%")
	vim.keymap.set({ "x", "o" }, "l%", "<plug>(matchup-i%)")

	local present, configs = pcall(require, "nvim-treesitter.configs")
	if present then
		configs.setup({
			matchup = {
				enable = true, -- mandatory, false will disable the whole extension
				-- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
			},
		})
	end
end

function treesitter.nvim_ts_context_commentstring()
	local present, configs = pcall(require, "nvim-treesitter.configs")
	if present then
		configs.setup({
			context_commentstring = {
				enable = true,
				enable_autocmd = false, -- for plugin: Comment.nvim
			},
		})
	end
end

function treesitter.comment()
	require("Comment").setup({
		pre_hook = function(ctx) -- for plugin: commentstring
			local U = require("Comment.utils")

			local location = nil
			if ctx.ctype == U.ctype.block then
				location = require("ts_context_commentstring.utils").get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = require("ts_context_commentstring.utils").get_visual_start_location()
			end

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
				location = location,
			})
		end,
	})
end

return treesitter
