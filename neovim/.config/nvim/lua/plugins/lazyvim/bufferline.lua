return {
	{
		"akinsho/bufferline.nvim",
		enabled = not vim.g.vscode,
		opts = {
			options = {
				indicator = {
					icon = '⏽',
				},
				separator_style = { '', '' },
			}
		},
		dependencies = {
			"tiagovla/scope.nvim",
			config = true
		},
	},
}
