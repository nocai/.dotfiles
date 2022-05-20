local m = {}

function m.config()
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			prompt_prefix = "  ",
			previewers = true,
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_next,
					["<C-e>"] = actions.move_selection_previous,
					["<C-l>"] = false,
					["<C-i>"] = actions.complete_tag,
				},
				n = {
					["j"] = false,
					["L"] = false,
					["n"] = actions.move_selection_next,
					["k"] = actions.move_selection_next,
					["p"] = actions.move_selection_previous,
					["e"] = actions.move_selection_previous,
					["I"] = actions.move_to_bottom,
				},
			},
		},
	})

	-- lua
	-- vim.cmd([[hi TelescopeNormal guibg=none]])
	-- vim.cmd([[hi TelescopeBorder guibg=none]])

	-- keymap
	vim.keymap.set("n", "<C-k><C-k>", [[<cmd>Telescope<CR>]])

	vim.keymap.set("n", "<C-k>f", [[<cmd>lua require('telescope.builtin').find_files({})<CR>]])
	vim.keymap.set("n", "<C-k><C-f>", [[<cmd>lua require('telescope.builtin').find_files({})<CR>]])

	vim.keymap.set("n", "<C-k>g", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
	vim.keymap.set("n", "<C-k><C-g>", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])

	vim.keymap.set("n", "<C-k>b", [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
	vim.keymap.set("n", "<C-k><C-b>", [[<cmd>lua require('telescope.builtin').buffers()<CR>]])

	vim.keymap.set("n", "<C-k>h", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
	vim.keymap.set("n", "<C-k><C-h>", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])

	vim.keymap.set("n", "<C-k><C-r>", [[<cmd>lua require("telescope.builtin").resume()<CR>]])
end

function m.telescope_fzf_native()
	require("telescope").setup({
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = false, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})
	require("telescope").load_extension("fzf")
end

function m.telescope_ui_selet()
	-- This is your opts table
	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					-- even more opts
				}),
			},
		},
	})
	require("telescope").load_extension("ui-select")
end

function m.lsp_keymap(opts)
	vim.keymap.set(
		"n",
		"gs",
		[[<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy({}))<CR>]],
		opts
	)
	vim.keymap.set(
		"n",
		"gr",
		[[<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy({}))<CR>]],
		opts
	)
	vim.keymap.set(
		"n",
		"gi",
		[[<cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_ivy({}))<CR>]],
		opts
	)
end

function m.telescope_project()
	require("telescope").setup({
		extensions = {
			project = {
				hidden_files = false, -- default: false
				theme = "dropdown",
			},
		},
	})
	require("telescope").load_extension("project")
end

function m.project()
	require("project_nvim").setup({
		exclude_dirs = { "~/.dotfiles/*/.config/*" },
	})
	require("telescope").load_extension("projects")
	vim.keymap.set("n", "<C-k>p", "<cmd>Telescope projects theme=dropdown<CR>")
	vim.keymap.set("n", "<C-k><C-p>", "<cmd>Telescope projects theme=dropdown<CR>")
end

return m
