-- vim.o.guifont = "Source Code Pro:h14"
vim.o.guifont = "JetBrainsMono Nerd Font:h12"

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.0
vim.g.transparency = 0.9
vim.g.neovide_background_color = "#1f2335" .. alpha()

vim.g.neovide_scroll_animation_length = 0.3
vim.g.neovide_input_macos_alt_is_meta = true

vim.g.neovide_cursor_vfx_mode = "railgun"
