if vim.g.vscode then
  return {}
end

-- vertical_bar = "┃",
-- vertical_bar_thin = "│",
-- left = "",
-- right = "",
-- block = "█",
-- left_filled = "",
-- right_filled = "",
-- slant_left = "",
-- slant_left_thin = "",
-- slant_right = "",
-- slant_right_thin = "",
-- slant_left_2 = "",
-- slant_left_2_thin = "",
-- slant_right_2 = "",
-- slant_right_2_thin = "",
-- left_rounded = "",
-- left_rounded_thin = "",
-- right_rounded = "",
-- right_rounded_thin = "",
-- circle = "●",

-- local nvimtree_extension = {
--   sections = {
--     lualine_c = { "filename" },
--     lualine_x = { "location" },
--   },
--   filetypes = { "NvimTree" },
-- }

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    enabled = not vim.g.vscode,
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          {
            "mode",
            icon = "",
            fmt = function(str)
              return str:sub(1, 3)
            end,
            color = { bg = "none" },
          },
        },
        lualine_c = {
          -- { "branch", icon = "" },
          { "branch" },
          {
            "diff",
            symbols = {
              added = ivim.icons.git.added,
              modified = ivim.icons.git.modified,
              removed = ivim.icons.git.removed,
            },
          },
          { "filetype", icon_only = true, padding = { left = 1 } },
          { "filename", separator = "»" },
          -- stylua: ignore
          {
            function() return require("nvim-navic").get_location() end,
            cond = function()
              return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
            end,
          },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = ivim.icons.diagnostics.Error,
              warn = ivim.icons.diagnostics.Warn,
              info = ivim.icons.diagnostics.Info,
              hint = ivim.icons.diagnostics.Hint,
            },
          },
          {
            "filetype",
            fmt = function(s)
              -- LSP status
              local client_names = {}
              for _, client in ipairs(vim.lsp.get_active_clients()) do
                if client.attached_buffers[vim.api.nvim_get_current_buf()] then
                  table.insert(client_names, client.name)
                end
              end
              if #client_names > 0 then
                return string.format("%s ~%s", s, vim.fn.join(client_names, "|"))
              end
              return s
            end,
          },
          "encoding",
          "fileformat",
          "progress",
          "location",
        },
        lualine_y = {},
        lualine_z = {},
      },
      -- extensions = { nvimtree_extension },
    },
    dependencies = {
      {
        "SmiteshP/nvim-navic",
        enabled = not vim.g.vscode,
        init = function()
          vim.g.navic_silence = true
          require("plugins.lsp.util").on_attach(function(client, buffer)
            if client.server_capabilities.documentSymbolProvider then
              require("nvim-navic").attach(client, buffer)
            end
          end)
        end,
        opts = function()
          return {
            separator = " > ",
            highlight = true,
            depth_limit = 5,
            icons = ivim.icons.kinds,
          }
        end,
      },
    },
  },
}
