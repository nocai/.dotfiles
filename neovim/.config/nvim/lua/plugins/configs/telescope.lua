local M = {}

function M.telescope()
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			prompt_prefix = "  ",
			previewers = true,
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		},
	})

	-- keymap
	vim.keymap.set("n", "<C-k><C-k>", [[<cmd>Telescope<CR>]])

	vim.keymap.set("n", "<C-k>f", [[<cmd>Telescope find_files<CR>]])
	vim.keymap.set("n", "<C-k><C-f>", [[<cmd>Telescope find_files<CR>]])

	vim.keymap.set("n", "<C-k>g", [[<cmd>Telescope live_grep<CR>]])
	vim.keymap.set("n", "<C-k><C-g>", [[<cmd>Telescope live_grep<CR>]])

	vim.keymap.set("n", "<C-k>b", [[<cmd>Telescope buffers<CR>]])
	vim.keymap.set("n", "<C-k><C-b>", [[<cmd>Telescope buffers<CR>]])

	vim.keymap.set("n", "<C-k>h", [[<cmd>Telescope help_tags<CR>]])
	vim.keymap.set("n", "<C-k><C-h>", [[<cmd>Telescope help_tags<CR>]])

	vim.keymap.set("n", "<C-k>o", [[<cmd>Telescope oldfiles<CR>]])
	vim.keymap.set("n", "<C-k><C-o>", [[<cmd>Telescope oldfiles<CR>]])

	vim.keymap.set("n", "<C-k>r", [[<cmd>Telescope resume<CR>]])
	vim.keymap.set("n", "<C-k><C-r>", [[<cmd>Telescope resume<CR>]])

	-- stylua: ignore start
	vim.keymap.set("n", "<Leader>gs", [[<cmd>Telescope lsp_document_symbols theme=get_ivy initial_mode=normal<CR>]])
	vim.keymap.set("n", "<Leader>gr", [[<cmd>Telescope lsp_references jump_type=never theme=get_ivy initial_mode=normal<CR>]])
	vim.keymap.set("n", "<Leader>gi", [[<cmd>Telescope lsp_implementations theme=get_ivy initial_mode=normal<CR>]])
	-- stylua: ignore end
end

function M.telescope_fzf_native()
	require("telescope").setup({
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})
	require("telescope").load_extension("fzf")
end

function M.telescope_ui_select()
	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					initial_mode = "normal",
				}),
			},
		},
	})
	require("telescope").load_extension("ui-select")
end

function M.telescope_project()
	require("telescope").setup({
		extensions = {
			project = {
				hidden_files = true, -- default: false
				sync_with_nvim_tree = true, -- default false
			},
		},
	})
	vim.keymap.set("n", "<C-k>p", "<cmd>lua require'telescope'.extensions.project.project{}<CR>")
	vim.keymap.set("n", "<C-k><C-p>", "<cmd>lua require'telescope'.extensions.project.project{}<CR>")
end

function M.project()
	-- projects
	vim.keymap.set("n", "<C-k>p", "<cmd>Telescope projects theme=dropdown<CR>")
	vim.keymap.set("n", "<C-k><C-p>", "<cmd>Telescope projects theme=dropdown<CR>")
	require("project_nvim").setup({
		show_hidden = true,
		-- silent_chdir = false,
		ignore_lsp = { "null-ls" },
	})
	require("telescope").load_extension("projects")
end

function M.todo_comments()
	require("todo-comments").setup({
		highlight = {
			before = "",
			after = "",
			keyword = "",
		},
	})
	vim.keymap.set("n", "<C-k>t", [[<cmd>TodoTelescope<CR>]])
	vim.keymap.set("n", "<C-k><C-t>", [[<cmd>TodoTelescope<CR>]])
end

return M
