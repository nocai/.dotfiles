return {
	{
		"hrsh7th/nvim-cmp",
		enabled = not vim.g.vscode,
		opts = {
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, item)
					local icons = require("lazyvim.config").icons.kinds
					if icons[item.kind] then
						item.kind = icons[item.kind]
					end
					item.menu = "[" .. entry.source.name .. "]"
					return item
				end
			},
		},
		config = function(_, opts)
			local cmp                 = require("cmp")

			local bordered            = cmp.config.window.bordered()
			bordered.winhighlight     = bordered.winhighlight .. ",FloatBorder:FloatBorder"

			opts.window               = opts.window or {}
			opts.window.completion    = bordered
			opts.window.documentation = bordered

			opts.mapping["<C-j>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			opts.mapping["<C-k>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })

			cmp.setup(opts)
		end
	},
}
