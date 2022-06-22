local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
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

-- keymap
vim.keymap.set("n", "<C-k><C-k>", [[<cmd>Telescope<CR>]])

vim.keymap.set("n", "<C-k>f", [[<cmd>lua require('telescope.builtin').find_files({hidden=true})<CR>]])
vim.keymap.set("n", "<C-k><C-f>", [[<cmd>lua require('telescope.builtin').find_files({hidden=true})<CR>]])

vim.keymap.set("n", "<C-k>g", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
vim.keymap.set("n", "<C-k><C-g>", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])

vim.keymap.set("n", "<C-k>b", [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set("n", "<C-k><C-b>", [[<cmd>lua require('telescope.builtin').buffers()<CR>]])

vim.keymap.set("n", "<C-k>h", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
vim.keymap.set("n", "<C-k><C-h>", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])

vim.keymap.set("n", "<C-k>o", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set("n", "<C-k><C-o>", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])

vim.keymap.set("n", "<C-k><C-r>", [[<cmd>lua require("telescope.builtin").resume()<CR>]])

-- stylua: ignore start
vim.keymap.set("n", "gs", [[<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy())<CR>]])
vim.keymap.set("n", "gr", [[<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy())<CR>]])
vim.keymap.set("n", "gi", [[<cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_ivy())<CR>]])
-- stylua: ignore end

local M = {}

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
				require("telescope.themes").get_dropdown({}),
			},
		},
	})
	require("telescope").load_extension("ui-select")
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

return M
