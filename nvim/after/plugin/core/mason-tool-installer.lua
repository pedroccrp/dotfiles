local helpers = require("helpers")

if helpers.is_remote_terminal() then
  return
end

local mason = helpers.safe_require("mason")
local mason_tool_installer = helpers.safe_require("mason-tool-installer")
if not mason or not mason_tool_installer then
  return
end

mason.setup({})

mason_tool_installer.setup({
  ensure_installed = {
    "gdtoolkit",
    "prettierd",
  },
  run_on_start = true,
})
