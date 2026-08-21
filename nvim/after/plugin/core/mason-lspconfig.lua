local helpers = require("helpers")

if helpers.is_remote_terminal() then
  return
end

local mason = helpers.safe_require("mason")
local mason_lspconfig = helpers.safe_require("mason-lspconfig")
if not mason or not mason_lspconfig then
  return
end

mason.setup({})

mason_lspconfig.setup({
  ensure_installed = {
    "dockerls",
    "jsonls",
    "sqlls",
    "eslint",
    "rust_analyzer",
    "bashls",
    "lua_ls",
    "kotlin_lsp",
  },
})
