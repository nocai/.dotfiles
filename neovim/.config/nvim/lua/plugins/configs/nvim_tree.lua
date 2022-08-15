require("nvim-tree").setup({
	hijack_cursor = true,

	reload_on_bufenter = true,
	create_in_closed_folder = true,
	diagnostics = nvim.diagnostics,

	respect_buf_cwd = true,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},

	renderer = {
		group_empty = true,
		highlight_opened_files = "name",
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = "after", -- "signcolumn"
		},
	},

	view = {
		adaptive_size = true,
		-- mappings = {
		-- 	list = {
		-- 		{ key = "<C-k>", action = "" },
		-- 		{ key = "<C-e>", action = "toggle_file_info" },
		-- 		{ key = "<C-p>", action = "preview" },
		-- 		{ key = "J", action = "" },
		-- 		{ key = "N", action = "last_sibling" },
		-- 		{ key = "K", action = "" },
		-- 		{ key = "E", action = "first_sibling" },
		-- 		{ key = "I", action = "" },
		-- 		{ key = "L", action = "toggle_ignored" },
		-- 		{ key = { "?", "g?" }, action = "toggle_help" },
		-- 	},
		-- },
	},
})

vim.keymap.set("n", "<leader><leader>", "<cmd>NvimTreeFindFileToggle<CR>")
-- auto close last windows in the tab
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
})
