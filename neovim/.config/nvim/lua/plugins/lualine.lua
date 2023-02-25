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
          { "branch", icon = "" },
          "diff",
          "diagnostics",
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
            "filetype",
            fmt = function(filetype)
              local result = filetype
              if vim.o.columns < 70 then
                return result
              end

              -- LSP status
              local client_names = {}
              for _, client in ipairs(vim.lsp.get_active_clients()) do
                if client.attached_buffers[vim.api.nvim_get_current_buf()] then
                  table.insert(client_names, client.name)
                end
              end

              if vim.tbl_isempty(client_names) then
                return result
              end

              result = string.format("%s ~%s", result, vim.fn.join(client_names, "|"))

              -- LSP progress
              local progresses = vim.lsp.util.get_progress_messages()
              if vim.tbl_isempty(progresses) then
                return result
              end

              local progress = progresses[1]
              local message = progress.message or ""
              local percentage = progress.percentage or 0
              local title = progress.title or ""

              local spinners = { "", "" }
              local hrtime = vim.loop.hrtime() / 1000000
              local frame = math.floor(hrtime / 120) % #spinners
              result = string.format("%s%%< %s %s %s (%s%%%%)", result, spinners[frame + 1], title, message, percentage)
              return result
            end,
          },
          -- "encoding",
          "fileformat",
          "progress",
          -- "location",
        },
        lualine_y = {},
        lualine_z = {},
      },
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
