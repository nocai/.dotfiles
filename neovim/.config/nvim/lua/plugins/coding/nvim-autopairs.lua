return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      map_c_w = true,
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({ tex = false }))
      end
    end,
  },
}
