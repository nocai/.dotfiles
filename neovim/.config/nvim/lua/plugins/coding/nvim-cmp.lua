return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      local bordered = cmp.config.window.bordered()

      return {
        experimental = {
          -- ghost_text = true,
        },
        performance = {
          max_view_entries = 20,
        },
        window = {
          completion = bordered,
          documentation = bordered,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local icons = ivim.icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind]
            end
            if string.len(item.abbr) > 25 then
              item.abbr = string.format("%s…", string.sub(item.abbr, 1, 25))
            end
            item.menu = string.format("[%s]", entry.source.name)
            return item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(3),
          ["<C-u>"] = cmp.mapping.scroll_docs(-3),
          ["<C-Space>"] = cmp.mapping.complete(),
          -- ["<C-e>"] = cmp.mapping.abort(),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if require("luasnip").expand_or_locally_jumpable() then
              require("luasnip").jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if require("luasnip").locally_jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      }
    end,
  },
}
