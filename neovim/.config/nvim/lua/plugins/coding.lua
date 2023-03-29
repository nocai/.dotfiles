if vim.g.vscode then
  return {}
end

return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "v", "n" } },
      { "gb", mode = { "n", "v" } },
    },
    opts = {},
  },
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "html" },
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    opts = {
      filetypes = { "*", "!lazy" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      trouble = false,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>hd", gs.diffthis, "Diff This")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewClose",
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewLog",
    },
  },
  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      -- { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      -- { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    },
    opts = {
      use_diagnostic_signs = true,
    },
    config = function(_, opts)
      require("trouble").setup(opts)
      -- require("gitsigns").setup({
      --   trouble = true,
      -- })
    end,
  },
  {
    "thinca/vim-quickrun",
    enabled = not vim.g.vscode,
    keys = {
      { "<leader>rr", "<Plug>(quickrun)", desc = "Code runner" },
    },
    init = function()
      vim.g.quickrun_no_default_key_mappings = 1
      vim.g.quickrun_config = { _ = { outputter = "message" } }
    end,
  },
  -- {
  -- 	"vim-test/vim-test",
  -- 	-- enabled = not vim.g.vscode,
  -- 	enabled = false,
  -- 	keys = {
  -- 		{ "<leader>tt", "<cmd>TestNearest<CR>", desc = "Test nearest" },
  -- 		{ "<leader>tf", "<cmd>TestFile<CR>",    desc = "Test file" },
  -- 		{ "<leader>ts", "<cmd>TestSuite<CR>",   desc = "Test suite" },
  -- 		{ "<leader>tl", "<cmd>TestLast<CR>",    desc = "Test last" },
  -- 		{ "<leader>tv", "<cmd>TestVisit<CR>",   desc = "Test visit" },
  -- 	},
  -- 	config = function()
  -- 		vim.cmd([[let test#strategy = "neovim"]])
  -- 	end,
  -- },
  {
    "chipsenkbeil/distant.nvim",
    cmd = {
      "DistantInstall",
      "DistantConnect",
      "DistantLaunch",
    },
    enabled = false,
    branch = "v0.2",
    config = function()
      require("distant").setup({
        -- ["10.15.47.191"] = {
        --   distant = {
        --     bin = "/home/nocai/.cargo/bin/distant",
        --   },
        -- },
        -- Applies Chip's personal settings to every machine you connect to
        --
        -- 1. Ensures that distant servers terminate with no connections
        -- 2. Provides navigation bindings for remote directories
        -- 3. Provides keybinding to jump into a remote file's parent directory
        ["*"] = require("distant.settings").chip_default(),
      })
    end,
  },
}
