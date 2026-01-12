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

vim.lsp.config("ruby_lsp", {
  cmd = { "ruby-lsp" },
})

vim.lsp.config("bashls", {
  filetypes = { "sh", "zsh" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.config("dockerls", {})
vim.lsp.config("jsonls", {})
vim.lsp.config("sqlls", {})
vim.lsp.config("eslint", {})
vim.lsp.config("rust_analyzer", {})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
vim.lsp.config("*", { capabilities = capabilities })
