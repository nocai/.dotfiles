-- stylua: ignore
local lspkind_icon = require("core.lspkind_icon")
local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
	-- completion = {
	-- 	keyword_length = 3,
	-- },
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
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
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
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
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

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

local M = {}

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
