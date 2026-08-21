local helpers = require("helpers")

local nvim_ts_autotag = helpers.safe_require("nvim-ts-autotag")
if not nvim_ts_autotag then
  return
end

nvim_ts_autotag.setup()
