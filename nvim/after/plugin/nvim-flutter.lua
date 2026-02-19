local helpers = require("helpers")

local flutter_tools = helpers.safe_require("flutter-tools")
if not flutter_tools then return end

flutter_tools.setup({
  dev_log = { enabled = true },
})
