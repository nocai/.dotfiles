return {
	{
		"windwp/nvim-spectre",
		enabled = false,
	},
	{
		"ggandor/flit.nvim",
		enabled = false
	},
	{
		"folke/trouble.nvim",
		enabled = false
	},
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	{
		"kyazdani42/nvim-tree.lua",
		enabled = false,
		keys = {
			{ "<leader><leader>", "<cmd>NvimTreeFindFileToggle<CR>", desc = "NvimTree find file toggle" },
		},
		opts = function()
			-- auto close last windows in the tab
			vim.api.nvim_create_autocmd("BufEnter", {
				nested = true,
				callback = function()
					if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
						vim.cmd("quit")
					end
				end,
			})

			return {
				hijack_cursor = true,
				reload_on_bufenter = true,
				respect_buf_cwd = true,
				sync_root_with_cwd = true,
				prefer_startup_root = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				renderer = {
					group_empty = true,
					indent_markers = {
						enable = true,
					},
					icons = {
						git_placement = "after", -- "signcolumn"
					},
				},
				view = {
					adaptive_size = true,
				},
			}
		end
	},
	{
		"folke/which-key.nvim",
		enabled = false,
	}

}
