local helpers = require("helpers")

if helpers.is_remote_terminal() then return end

local flutter_tools = helpers.safe_require("flutter-tools")
if not flutter_tools then return end

flutter_tools.setup({
  dev_log = { enabled = true },
})
