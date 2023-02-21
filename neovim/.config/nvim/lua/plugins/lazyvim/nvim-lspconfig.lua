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
		enabled = not vim.g.vscode,
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
			local keys = require("lazyvim.config").map_keys

			local keymaps = require("lazyvim.plugins.lsp.keymaps").get()
			keymaps[#keymaps + 1] = { "gr", false }
			keymaps[#keymaps + 1] = {
				keys.GotoReferences,
				"<cmd>Telescope lsp_references theme=get_ivy<cr>",
				desc = "References",
			}

			keymaps[#keymaps + 1] = { "gt", false }
			keymaps[#keymaps + 1] = {
				keys.GotoTypeDefinition,
				"<cmd>Telescope lsp_type_definitions<cr>",
				desc = "Goto Type Definition",
			}

			keymaps[#keymaps + 1] = {
				keys.GotoSymbols,
				"<cmd>Telescope lsp_document_symbols theme=get_ivy<cr>",
				desc = "Document symbols"
			}

			keymaps[#keymaps + 1] = { "gI", false }
			keymaps[#keymaps + 1] = {
				keys.GotoImplementation,
				"<cmd>Telescope lsp_implementations theme=get_ivy<cr>",
				desc = "Implementations"
			}

			keymaps[#keymaps + 1] = { "<leader>gR", "<cmd>Telescope resume<cr>", desc = "Resume" }
		end,
	},
}
