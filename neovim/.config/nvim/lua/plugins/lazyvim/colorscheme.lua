return {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = not vim.g.vscode,
		opts = {
			transparent_background = true,
			integrations = {
				fidget = true,
				symbols_outline = true,
				leap = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = true,
				},
			},
		},
	},
}
