return {
	{
		"telescope.nvim",
		cond = not vim.g.vscode,
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		keys = {
			{ "<leader>,",       false },
			{ "<leader><space>", false },
		}
	},

}
