local M = {}

function M.nvim_cmp()
  local lspkind_icon = require("core.lspkind_icon").codicon
  local cmp = require("cmp")

  local cmpwin = cmp.config.window.bordered({
    winhighlight = cmp.config.window.bordered().winhighlight .. ",FloatBorder:FloatBorder",
  })

  cmp.setup({
    -- preselect = cmp.PreselectMode.None,
    window = {
      completion = cmpwin,
      documentation = cmpwin,
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
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 10000 },
      { name = "nvim_lua" },
      { name = "cmp_tabnine" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
      { name = "path" },
    }),
    experimental = {
      -- ghost_text = true,
    },
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  -- `:` cmdline setup.
  -- cmp.setup.cmdline(':', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })
end

function M.luasnip()
  local luasnip = require("luasnip")
  luasnip.setup({
    region_check_events = "InsertEnter,InsertLeave",
    delete_check_events = "InsertEnter,InsertLeave",
  })
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
      if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })

  local cmp = require("cmp")
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
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
