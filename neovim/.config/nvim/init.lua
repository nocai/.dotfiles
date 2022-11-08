vim.defer_fn(function()
	pcall(require, "impatient")
end, 0)

require("nvim")
require("option")
require("autocmd")

local pp = require("plugins.packer")

local packer_bootstrap = pp.ensure_packer()

local packer = pp.init()
packer.startup({ require("plugins") })

if packer_bootstrap then
	packer.sync()
end
