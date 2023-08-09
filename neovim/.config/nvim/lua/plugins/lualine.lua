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

if vim.g.vscode then
  return {}
end

local nvimtree_extension = {
  sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" },
  },
  filetypes = { "NvimTree" },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "mode",
            icon = "",
            fmt = function(str)
              return str:sub(1, 3)
            end,
            -- color = { bg = "none" },
            color = function()
              -- stylua: ignore
              local colors = {
                bg       = '#202328',
                fg       = '#bbc2cf',
                yellow   = '#ECBE7B',
                cyan     = '#008080',
                darkblue = '#081633',
                green    = '#98be65',
                orange   = '#FF8800',
                violet   = '#a9a1e1',
                magenta  = '#c678dd',
                blue     = '#51afef',
                red      = '#ec5f67',
              }
              -- auto change color according to neovims mode
              local mode_color = {
                n = colors.red,
                i = colors.green,
                v = colors.blue,
                [""] = colors.blue,
                V = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.red,
                t = colors.red,
              }
              return { fg = mode_color[vim.fn.mode()] }
            end,
          },
          { "branch", icon = "󰊢" },
          {
            "diff",
            symbols = {
              added = ivim.icons.git.added,
              modified = ivim.icons.git.modified,
              removed = ivim.icons.git.removed,
            },
          },
          { "filetype", icon_only = true, padding = { left = 1 } },
          { "filename" },
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
                return string.format("%s [%s]", s, vim.fn.join(client_names, ","))
              end
              return s
            end,
          },
          "encoding",
          "fileformat",
          "location",
          "progress",
        },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { nvimtree_extension },
    },
  },
}
