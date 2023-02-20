return {
	{
		"akinsho/bufferline.nvim",
		cond = not vim.g.vscode,
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
