return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      local bordered = cmp.config.window.bordered()
      -- bordered.winhighlight = string.format("%s,FloatBorder:FloatBorder", bordered.winhighlight)

      local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end

      return {
        -- performance = {
        --   max_view_entries = 20,
        -- },
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
        experimental = {
          -- ghost_text = {
          --   hl_group = "LspCodeLens",
          -- },
        },
        window = {
          completion = bordered,
          documentation = bordered,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(3),
          ["<C-u>"] = cmp.mapping.scroll_docs(-3),
          -- ["<C-Space>"] = cmp.mapping.complete(),
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
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      }
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "windwp/nvim-autopairs",
        opts = {
          check_ts = true,
          map_c_w = true,
          -- map_c_h = true,
          -- fast_wrap = {
          --   map = "<M-e>",
          --   chars = { "{", "[", "(", '"', "'" },
          --   pattern = [=[[%'%"%>%]%)%}%,]]=],
          --   end_key = "$",
          --   keys = "qwertyuiopzxcvbnmasdfghjkl",
          --   check_comma = true,
          --   manual_position = false,
          --   highlight = "Search",
          --   highlight_grey = "Comment",
          -- },
        },
      },
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
  },
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-cmp" },
    opts = {
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "<", close = ">" },
      },
    },
  },
}
