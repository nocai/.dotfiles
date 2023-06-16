if vim.g.vscode then
  return {}
end

return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    enabled = not vim.g.vscode,
    opts = function()
      local cmp = require("cmp")
      local bordered = cmp.config.window.bordered()
      bordered.winhighlight = string.format("%s,FloatBorder:FloatBorder", bordered.winhighlight)

      return {
        window = {
          completion = bordered,
          documentation = bordered,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(3),
          ["<C-u>"] = cmp.mapping.scroll_docs(-3),
          ["<C-f>"] = cmp.mapping.scroll_docs(6),
          ["<C-b>"] = cmp.mapping.scroll_docs(-6),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
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
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        -- auto pairs
        "windwp/nvim-autopairs",
        opts = {
          check_ts = true,
          map_c_w = true,
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      {
        -- snippets
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            vim.api.nvim_create_autocmd("InsertLeave", {
              callback = function()
                if
                  require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                  and not require("luasnip").session.jump_active
                then
                  require("luasnip").unlink_current()
                end
              end,
            })
          end,
        },
        opts = {
          history = true,
          updateevents = "TextChanged,TextChangedI",
        },
        -- stylua: ignore
        keys = {
          {
            "<tab>",
            function()
              return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true, silent = true, mode = "i",
          },
          { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
          { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
      },
    },
  },
}
