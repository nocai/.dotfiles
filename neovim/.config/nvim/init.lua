vim.defer_fn(function()
	pcall(require, "impatient")
end, 0)

require("nvim")
require("option")
require("autocmd")

local packer_bootstrap = require("core.packer").ensure_packer()
local packer = require("core.packer").init()

local plugins = require("plugins")
packer.startup({ plugins })
if packer_bootstrap then
	packer.sync()
end
