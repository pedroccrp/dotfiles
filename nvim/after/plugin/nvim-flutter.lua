local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("flutter-tools").setup({
  lsp = { capabilities = capabilities },
  dev_log = { enabled = true },
})
