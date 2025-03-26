local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    ruby = { "rubocop" },
    dart = { "dart_format" },
    kotlin = { "ktlint" },
  },
  formatters = {
    rubocop = {
      command = "bundle",
      args = { "exec", "rubocop", "-A", "--stderr", "--force-exclusion", "--stdin", "$FILENAME" },
    },
  },
})

vim.keymap.set("n", "<leader>cf", function()
  conform.format({ lsp_fallback = true, timeout_ms = 5000 })
end)
