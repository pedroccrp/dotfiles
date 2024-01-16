require('trim').setup({
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  ft_blocklist = {"markdown"},
  -- if you want to disable trim on write by default
  trim_on_write = true,
  trim_trailing = true,
  trim_first_line = false,
  trim_last_line = true,
})
