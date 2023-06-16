local conditions = require("heirline.conditions")

local Diagnostics = {

  condition = conditions.has_diagnostics,

  static = {
    error_icon = ivim.icons.diagnostics.Error,
    warn_icon = ivim.icons.diagnostics.Warn,
    info_icon = ivim.icons.diagnostics.Info,
    hint_icon = ivim.icons.diagnostics.Hint,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = " ![",
    hl = { fg = "red" },
  },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      local warnings = self.warnings
      local info = self.info
      local hints = self.hints
      if warnings > 0 or info > 0 or hints then
        return self.errors > 0 and (self.error_icon .. self.errors .. "")
      else
        return self.errors > 0 and (self.error_icon .. self.errors)
      end
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      local info = self.info
      local hints = self.hints
      if info > 0 or hints > 0 then
        return self.warnings > 0 and (self.warn_icon .. self.warnings .. "")
      else
        return self.warnings > 0 and (self.warn_icon .. self.warnings)
      end
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      local hints = self.hints
      if hints > 0 then
        return self.info > 0 and (self.info_icon .. self.info .. "")
      else
        return self.info > 0 and (self.info_icon .. self.info)
      end
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
  {
    provider = " ] ",
    hl = { fg = "red" },
  },
  -- hl = { bg = "#000000"},
}

return Diagnostics
