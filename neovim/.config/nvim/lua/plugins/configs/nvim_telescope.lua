local M = {}

function M.telescope()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      prompt_prefix = "  ",
      previewers = true,
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
  })
end

function M.telescope_fzf_native()
  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  }
  require('telescope').load_extension('fzf')
end

function M.telescope_ui_select()
  require("telescope").setup({
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          initial_mode = "normal",
        }),
      },
    },
  })
  require("telescope").load_extension("ui-select")
end

function M.telescope_project()
  require("telescope").setup({
    extensions = {
      project = {
        hidden_files = true, -- default: false
        sync_with_nvim_tree = true, -- default false
      },
    },
  })
end

return M
