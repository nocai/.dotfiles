local vi_mode_utils = require("feline.providers.vi_mode")
local colors = require("tokyonight.colors").setup({})

require("feline").setup({
	theme = {
		fg = "oceanblue",
		bg = colors.bg_statusline,
	},
	components = {
		active = {
			-- left
			{
				{
					provider = {
						name = "vi_mode",
						opts = {
							show_mode_name = true,
						},
						hl = function()
							return {
								name = vi_mode_utils.get_mode_highlight_name(),
								fg = vi_mode_utils.get_mode_color(),
								style = "bold",
							}
						end,
					},
				},
				{
					provider = "file_info",
				},
			},

			-- right
			{},
		},
		inactive = {},
	},
})
