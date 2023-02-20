return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		cond = not vim.g.vscode,
		keys = {
			{ "<leader><leader>", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		}
	}
}
