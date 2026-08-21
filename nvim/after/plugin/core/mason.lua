local helpers = require("helpers")

if helpers.is_remote_terminal() then
  return
end

local mason = helpers.safe_require("mason")
if not mason then
  return
end

mason.setup({})
