local helpers = require("helpers")

local which_key = helpers.safe_require("which-key")
if not which_key then return end

which_key.setup({
  delay = 800,
})
