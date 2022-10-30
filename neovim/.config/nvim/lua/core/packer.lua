local M = {}

function M.ensure_packer()
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
		return true
	end
	return false
end

function M.init()
	vim.cmd("packadd packer.nvim")
	local packer = require("packer")

	packer.init({
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
			prompt_border = "rounded",
		},
		git = {
			default_url_format = "https://ghproxy.com/https://github.com/%s",
		},
		auto_clean = true,
		compile_on_sync = true,
	})

	vim.cmd([[
		augroup packer_user_config
			autocmd!
			autocmd BufWritePost init.lua source <afile> | PackerCompile
		augroup end
	]])

	return packer
end

return M
