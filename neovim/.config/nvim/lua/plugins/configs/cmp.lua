-- stylua: ignore
local lspkind_icon = require("core.lspkind_icon")
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	-- preselect = cmp.PreselectMode.None,
	window = {
		completion = {
			border = nvim.window.border,
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None," .. nvim.window.winhighlight,
		},
		documentation = {
			border = nvim.window.border,
			winhighlight = nvim.window.winhighlight,
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = lspkind_icon[vim_item.kind] .. " "

			local maxwidth = 30
			if string.len(vim_item.abbr) > maxwidth then
				vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth) .. "…"
			end

			vim_item.menu = "[" .. entry.source.name .. "]"
			return vim_item
		end,
	},
	-- You must set mapping.
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),

		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),

		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			select = true,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "cmp_tabnine" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
		-- { name = "nvim_lua" },
	}),
	experimental = {
		-- ghost_text = true,
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

local M = {}

function M.luasnip()
	require("luasnip").setup({
		region_check_events = "InsertEnter",
	})
	require("luasnip.loaders.from_vscode").lazy_load()
	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
					and not require("luasnip").session.jump_active
			then
				require("luasnip").unlink_current()
			end
		end,
	})
end

function M.nvim_autopairs()
	require("nvim-autopairs").setup({
		check_ts = true,
		map_c_w = true, -- map <c-w> to delete a pair if possible
		-- map_c_h = true,
	})
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
