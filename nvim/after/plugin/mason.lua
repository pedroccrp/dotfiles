require("mason").setup({})

require("mason-lspconfig").setup({
  ensure_installed = {
    "dockerls",
    "jsonls",
    "ruby_lsp",
    "sqlls",
    "eslint",
    "rust_analyzer",
    "bashls",
    "lua_ls",
  },
})
