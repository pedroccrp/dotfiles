local helpers = require("helpers")

local nvim_surround = helpers.safe_require("nvim-surround")
if not nvim_surround then
  return
end

nvim_surround.setup({})
