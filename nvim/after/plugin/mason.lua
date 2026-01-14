require("mason").setup({})

require("mason-tool-installer").setup({
  ensure_installed = {
    "gdtoolkit",
    "prettierd",
  },
  run_on_start = true,
})

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
