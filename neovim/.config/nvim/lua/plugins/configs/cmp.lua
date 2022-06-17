-- stylua: ignore
local lspkind_icon = require("core.lspkind_icon")
local cmp = require("cmp")

vim.opt.completeopt = "menuone,noselect"

-- local cmp_window = require("cmp.utils.window")
--
-- cmp_window.info_ = cmp_window.info
-- cmp_window.info = function(self)
-- 	local info = self:info_()
-- 	info.scrollable = false
-- 	return info
-- end

cmp.setup({
	-- preselect = cmp.PreselectMode.None,
	completion = {
		keyword_length = 3,
	},
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
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		duplicates_default = 0,
		format = function(entry, vim_item)
			vim_item.kind = lspkind_icon[vim_item.kind] .. " "

			local maxwidth = 30
			if string.len(vim_item.abbr) > maxwidth then
				vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth) .. "…"
			end

			local source_names = {
				nvim_lsp = "(LSP)",
				nvim_lua = "(NLua)",
				emoji = "(Emoji)",
				path = "(Path)",
				calc = "(Calc)",
				cmp_tabnine = "(Tabn)",
				vsnip = "(Snip)",
				luasnip = "(Snip)",
				buffer = "(Buff)",
			}
			vim_item.menu = source_names[entry.source.name]

			-- local duplicates = {
			-- 	buffer = 1,
			-- 	path = 1,
			-- 	nvim_lsp = 0,
			-- 	luasnip = 1,
			-- }
			-- vim_item.dup = duplicates[entry.source.name]
			return vim_item
		end,
	},
	-- You must set mapping.
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_next_item(),
		["<C-e>"] = cmp.mapping.select_prev_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		-- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-j>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})
