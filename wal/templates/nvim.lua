local colors = {
  background = "{background}",
  foreground = "{foreground}",
  color0 = "{color0}",
  color1 = "{color1}",
  color2 = "{color2}",
  color3 = "{color3}",
  color4 = "{color4}",
  color5 = "{color5}",
  color6 = "{color6}",
  color7 = "{color7}",
  color8 = "{color8}",
  color9 = "{color9}",
  color10 = "{color10}",
  color11 = "{color11}",
  color12 = "{color12}",
  color13 = "{color13}",
  color14 = "{color14}",
  color15 = "{color15}",
}

vim.g.terminal_color_0 = colors.color0
vim.g.terminal_color_1 = colors.color1
vim.g.terminal_color_2 = colors.color2
vim.g.terminal_color_3 = colors.color3
vim.g.terminal_color_4 = colors.color4
vim.g.terminal_color_5 = colors.color5
vim.g.terminal_color_6 = colors.color6
vim.g.terminal_color_7 = colors.color7
vim.g.terminal_color_8 = colors.color8
vim.g.terminal_color_9 = colors.color9
vim.g.terminal_color_10 = colors.color10
vim.g.terminal_color_11 = colors.color11
vim.g.terminal_color_12 = colors.color12
vim.g.terminal_color_13 = colors.color13
vim.g.terminal_color_14 = colors.color14
vim.g.terminal_color_15 = colors.color15

vim.api.nvim_set_hl(0, "Normal", { fg = colors.foreground, bg = colors.background })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.foreground, bg = colors.background })
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.color8, bg = colors.background })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.color4, bg = colors.background, bold = true })
vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.foreground, bg = colors.color0 })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.color7, bg = colors.color0 })
