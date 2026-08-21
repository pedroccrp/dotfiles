local helpers = require("helpers")

local navic = helpers.safe_require("nvim-navic")
if not navic then
  return
end

navic.setup({
  highlight = true,
  separator = " > ",
})
