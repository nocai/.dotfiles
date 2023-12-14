return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    enabled = not vim.g.vscode,
    opts = {
      indent = {
        -- char = "▏",
        char = "┊",
      },
      scope = {
        enabled = true,
        show_start = false,
      },
    },
  }
