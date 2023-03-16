local M = {}

function M.load()
  local function _load(mod)
    local modname = "config." .. mod

    local Util = require("lazy.core.util")
    Util.try(function()
      require(modname)
    end, {
      msg = "Failed loading " .. mod,
      on_error = function(msg)
        vim.nofity(msg)
      end,
    })
  end

  _load("options")
  if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
      pattern = "VeryLazy",
      callback = function()
        _load("keymaps")
        if not vim.g.vscode then
          _load("autocmds")
        end
      end,
    })
  else
    -- load them now so they affect the opened buffers
    _load("keymaps")
    if not vim.g.vscode then
      _load("autocmds")
    end
  end
end

---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

return M
