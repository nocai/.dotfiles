return {
	-- by enabled
	-- 快捷键s开头，与leap.nvim冲突
	{
		"echasnovski/mini.surround",
		enabled = false,
	},
	{
		"windwp/nvim-spectre",
		enabled = false,
	},
	{
		"ggandor/flit.nvim",
		enabled = false
	},
	{
		"rcarriga/nvim-notify",
		enabled = false
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
	},
	{
		"folke/noice.nvim",
		enabled = false
	},
	{
		"SmiteshP/nvim-navic",
		enabled = false
	},

	-- by enabled
	{
		"L3MON4D3/LuaSnip",
		enabled = not vim.g.vscode
	},
	{
		"echasnovski/mini.pairs",
		enabled = not vim.g.vscode,
	},
	{
		"folke/which-key.nvim",
		enabled = not vim.g.vscode,
	},
	{
		"lewis6991/gitsigns.nvim",
		enabled = not vim.g.vscode,
	},
	{
		"RRethy/vim-illuminate",
		enabled = not vim.g.vscode,
	},
	{
		"echasnovski/mini.bufremove",
		enabled = not vim.g.vscode,
	},
	{
		"folke/trouble.nvim",
		enabled = not vim.g.vscode,
	},
	{
		"folke/todo-comments.nvim",
		enabled = not vim.g.vscode,
	},
	{
		"stevearc/dressing.nvim",
		enabled = not vim.g.vscode,
	},
	{
		"goolord/alpha-nvim",
		enabled = not vim.g.vscode,
	},
	{
		"nvim-tree/nvim-web-devicons",
		enabled = not vim.g.vscode,
	},
	{
		"MunifTanjim/nui.nvim",
		enabled = not vim.g.vscode,
	},
	{
		"dstein64/vim-startuptime",
		enabled = not vim.g.vscode,
	},
	{
		"folke/persistence.nvim",
		enabled = not vim.g.vscode,
	},
}
