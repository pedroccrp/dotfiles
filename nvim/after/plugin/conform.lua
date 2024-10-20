local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    ruby = { "rubocop" },
    dart = { "dart_format" },
  },
  formatters = {
    rubocop = {
      args = { "-A", "--stderr", "--force-exclusion", "--stdin", "$FILENAME" },
    },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
})
