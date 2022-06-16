-- I want to use Git instead of curl for downloading the parsers
require("nvim-treesitter.install").prefer_git = true
-- I want to use a mirror instead of "https://github.com/"
for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
	config.install_info.url = config.install_info.url:gsub(
		"https://github.com/",
		"https://ghproxy.com/https://github.com/"
	)
end

require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "go" },
	highlight = {
		enable = nvim.is_not_vscode,
		additional_vim_regex_highlighting = false,
		use_languagetree = true,
	},
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

	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["as"] = "@statement.outer",
				-- ["lb"] = "@block.inner",
				-- ["ab"] = "@block.outer",
				["lf"] = "@function.inner",
				["af"] = "@function.outer",
				["lc"] = "@class.inner",
				["ac"] = "@class.outer",
				["la"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["li"] = "@conditional.inner",
				["ai"] = "@conditional.outer",
				["ll"] = "@loop.inner",
				["al"] = "@loop.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				-- ["]b"] = "@block.outer",
				["]s"] = "@statement.outer",
				["]l"] = "@loop.outer",
				["]i"] = "@conditional.outer",
				["]a"] = "@parameter.outer",
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				-- ["]B"] = "@block.outer",
				["]S"] = "@statement.outer",
				["]L"] = "@loop.outer",
				["]I"] = "@conditional.outer",
				["]A"] = "@parameter.outer",
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				-- ["[b"] = "@block.outer",
				["[s"] = "@statement.outer",
				["[l"] = "@loop.outer",
				["[i"] = "@conditional.outer",
				["[a"] = "@parameter.outer",
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				-- ["[B"] = "@block.outer",
				["[S"] = "@statement.outer",
				["[L"] = "@loop.outer",
				["[I"] = "@conditional.outer",
				["[A"] = "@parameter.outer",
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
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
			border = "rounded",
			peek_definition_code = {
				["<C-p>f"] = "@function.outer",
				["<C-p>c"] = "@class.outer",
			},
		},
	},
})

if nvim.is_not_vscode then
	vim.api.nvim_command("set foldmethod=expr")
	vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
end
