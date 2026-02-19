local helpers = require("helpers")

local trim = helpers.safe_require("trim")
if not trim then return end

trim.setup({
  ft_blocklist = {"markdown"},
  trim_on_write = true,
  trim_trailing = true,
  trim_first_line = false,
  trim_last_line = true,
})
