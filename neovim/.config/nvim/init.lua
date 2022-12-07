vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require("nvim")
require("option")
require("autocmd")

local p = require("plugins.configs.packer")
local bootstrap = p.ensure_packer()

local packer = p.init()
packer.startup({ require("plugins") })

if bootstrap then
  packer.sync()
end
