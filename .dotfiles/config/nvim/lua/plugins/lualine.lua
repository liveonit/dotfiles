-- Lualine --
local theme = require 'plugins.lualine_theme'

require 'lualine'.setup {
  options = {
    theme = theme.theme()
  },
  sections = { lualine_x = { 'filetype' },
  lualine_y = { 'progress' } }
}
