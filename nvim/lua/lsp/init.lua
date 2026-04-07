local helpers = require("helpers")

if helpers.is_remote_terminal() then
  return
end

require("lsp.servers")
require("lsp.capabilities")
require("lsp.diagnostics")
require("lsp.keymaps")
