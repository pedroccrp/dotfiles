require("marks").setup({
  default_mappings = true,
  builtin_marks = {},
  cyclic = true,
  force_write_shada = false,
  refresh_interval = 150,
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  excluded_filetypes = {},
  excluded_buftypes = {},
  mappings = {},
})
