return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		-- enabled = not vim.g.vscode,
		enabled = false,
		keys = {
			{ "<leader><leader>", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		}
	}
}
