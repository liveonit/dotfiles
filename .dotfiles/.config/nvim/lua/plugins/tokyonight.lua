require("tokyonight").setup({
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = true, -- Enable this to disable setting the background color
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = { italic = false },
    sidebars = "transparent", -- style for sidebars, see below
    floats = "transparent", -- style for floating windows
  }
})
vim.cmd [[colorscheme tokyonight ]]
