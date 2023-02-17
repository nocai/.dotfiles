return {
	{
		"windwp/nvim-ts-autotag",
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
					filetypes = { "html", "xml" },
				},
			})
		end
	},
	{
		"p00f/nvim-ts-rainbow",
		event = { "VeryLazy" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
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
	}
}
