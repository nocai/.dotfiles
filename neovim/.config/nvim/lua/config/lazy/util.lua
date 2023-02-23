local M = {}

---@param name string
function M.opts(name)
	local plugin = require("lazy.core.config").plugins[name]
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end


-- FIXME: create a togglable terminal
-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean}
function M.float_term(cmd, opts)
	opts = vim.tbl_deep_extend("force", {
		size = { width = 0.9, height = 0.9 },
	}, opts or {})
	require("lazy.util").float_term(cmd, opts)
end

return M