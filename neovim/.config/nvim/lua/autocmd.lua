local autocmd = vim.api.nvim_create_autocmd

-- open nvim with a dir while still lazy loading nvimtree
-- autocmd("BufEnter", {
-- 	callback = function()
-- 		if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
-- 			vim.cmd("lcd %:p:h")
-- 		end
-- 	end,
-- })

-- Open a file from its last left off position
-- autocmd("BufReadPost", {
-- 	callback = function()
-- 		if not vim.fn.expand("%:p"):match(".git") and vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
-- 			vim.cmd("normal! g'\"")
-- 			-- vim.cmd("normal zz")
-- 		end
-- 	end,
-- })

-- Highlight yanked text
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

autocmd("InsertLeave", {
	callback = function()
		local present, luasnip = pcall(require, "luasnip")
		if not present then
			return
		end

		if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
			luasnip.unlink_current()
		end
	end,
})
