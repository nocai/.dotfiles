return {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = true,
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
		lazy = true,
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
