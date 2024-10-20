local lsp_zero = require("lsp-zero")

require("mason").setup({})

require("mason-lspconfig").setup({
  ensure_installed = {
    "ast_grep", -- works for multiple languages
    "dockerls",
    "jsonls",
    "solargraph",
    "sqlls",
    "eslint",
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require("lspconfig").lua_ls.setup(lua_opts)
    end,
  },
})

require("mason-conform").setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d",
    "rubocop",
    "dart_format",
  },
  automatic_installation = true,
})

require("mason-nvim-dap").setup({
  ensure_installed = {},
})
