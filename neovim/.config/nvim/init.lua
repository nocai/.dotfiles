vim.defer_fn(function()
	pcall(require, "impatient")
end, 0)

require("nvim")
require("option")
require("autocmd")

-- install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	print("Cloning packer ..")
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://ghproxy.com/https://github.com/wbthomason/packer.nvim",
		install_path,
	})

	vim.cmd("packadd packer.nvim")
	local present, packer = pcall(require, "packer")
	if present then
		print("Packer cloned successfully.")
		require("plugins")
		vim.cmd("PackerSync")
	else
		error("Couldn't clone packer !\nPacker path: " .. install_path .. "\n" .. packer)
	end
end
vim.cmd("packadd packer.nvim")
require("plugins")
