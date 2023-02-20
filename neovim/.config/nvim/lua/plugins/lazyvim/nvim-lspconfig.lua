vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	silent = true,
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	silent = true,
	border = "rounded",
})

return {
	{
		"neovim/nvim-lspconfig",
		cond = not vim.g.vscode,
		opts = {
			servers = {
				jsonls = false,
			},
			diagnostics = {
				float = {
					focusable = false,
					border = "rounded"
				},
			}
		},
		init = function(_, opts)
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "gr", false }
			keys[#keys + 1] = {
				"<leader>gr",
				"<cmd>Telescope lsp_references theme=get_ivy<cr>",
				desc = "References",
			}

			keys[#keys + 1] = { "gt", false }
			keys[#keys + 1] = {
				"gy",
				"<cmd>Telescope lsp_type_definitions<cr>",
				desc = "Goto Type Definition",
			}

			keys[#keys + 1] = {
				"<leader>gs",
				"<cmd>Telescope lsp_document_symbols theme=get_ivy<cr>",
				desc = "Document symbols"
			}

			keys[#keys + 1] = { "gI", false }
			keys[#keys + 1] = {
				"<leader>gi",
				"<cmd>Telescope lsp_implementations theme=get_ivy<cr>",
				desc = "Implementations"
			}

			keys[#keys + 1] = { "<leader>gR", "<cmd>Telescope resume<cr>", desc = "Resume" }
		end,
	},
}
