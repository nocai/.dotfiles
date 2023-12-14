return {
  "NvChad/nvim-colorizer.lua",
  event = "VeryLazy",
  enabled = false,
  config = function()
    require'colorizer'.setup()
  end
}
