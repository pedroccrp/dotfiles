local helpers = require("helpers")

local nvim_autopairs = helpers.safe_require("nvim-autopairs")
if not nvim_autopairs then
  return
end

nvim_autopairs.setup()
