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
