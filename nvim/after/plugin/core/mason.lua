local helpers = require("helpers")

local mason = helpers.safe_require("mason")
local mason_tool_installer = helpers.safe_require("mason-tool-installer")
local mason_lspconfig = helpers.safe_require("mason-lspconfig")

if not mason or not mason_tool_installer or not mason_lspconfig then return end

mason.setup({})

mason_tool_installer.setup({
  ensure_installed = {
    "gdtoolkit",
    "prettierd",
  },
  run_on_start = true,
})

mason_lspconfig.setup({
  ensure_installed = {
    "dockerls",
    "jsonls",
    "ruby_lsp",
    "sqlls",
    "eslint",
    "rust_analyzer",
    "bashls",
    "lua_ls",
    "kotlin_lsp",
  },
})
