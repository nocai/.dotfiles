return {
	{
		"nvim-telescope/telescope.nvim",
		version = false, -- telescope did only one release, so use HEAD for now
		cmd = "Telescope",
		enabled = not vim.g.vscode,
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},
		keys = function()
			return require("plugins.telescope.keymaps")
		end,
		opts = {
			prompt_prefix = "  ",
			previewers = true,
		}
	},

}
