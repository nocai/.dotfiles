return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "┊",
      },
      scope = {
        enabled = true,
        show_start = false,
      },
    },
  }
