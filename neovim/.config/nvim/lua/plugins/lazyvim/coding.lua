return {
	{
		"hrsh7th/nvim-cmp",
		opts = {
			window = {
				completion = {
					border = "rounded",
					winhighlight = "FloatBorder:FloatBorder",
				},
				documentation = {
					border = "rounded",
					winhighlight = "FloatBorder:FloatBorder",
				}
			},
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
			}
		},
	},

	-- surround
	-- 快捷键s开头，与leap.nvim冲突
	{
		"echasnovski/mini.surround",
		enabled = false,
	},
	{
		"kylechui/nvim-surround",
		event = { "VeryLazy" },
		config = function()
			require("nvim-surround").setup()
		end,
	},
}
