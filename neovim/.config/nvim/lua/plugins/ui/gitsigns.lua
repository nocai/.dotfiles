return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    trouble = false,
    current_line_blame = true,
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

        -- stylua: ignore start
        map({ "n", "v" }, "<leader>gs", gs.stage_hunk, "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")

        map("n", "[h", function()
          if vim.wo.diff then return ']h' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, "Prev Hunk")
        map("n", "]h", function()
          if vim.wo.diff then return '[h' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, "Next Hunk")

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}
