-- I want to use Git instead of curl for downloading the parsers
require("nvim-treesitter.install").prefer_git = true
-- I want to use a mirror instead of "https://github.com/"
for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
	config.install_info.url =
	config.install_info.url:gsub("https://github.com/", "https://ghproxy.com/https://github.com/")
end

require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "go" },
	highlight = {
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
				-- ["ib"] = "@block.inner",
				-- ["ab"] = "@block.outer",
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["ic"] = "@class.inner",
				["ac"] = "@class.outer",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["ii"] = "@conditional.inner",
				["ai"] = "@conditional.outer",
				["il"] = "@loop.inner",
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

vim.api.nvim_command("set foldmethod=expr")
vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

local M = {}

function M.nvim_ts_rainbow()
	require("nvim-treesitter.configs").setup({
		rainbow = {
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},
	})
end

function M.nvim_ts_autotag()
	require("nvim-treesitter.configs").setup({
		autotag = {
			enable = true,
			filetypes = { "html", "xml" },
		},
	})
end

return M
