local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    dart = { "dart_format" },
    kotlin = { "ktlint" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    html = { "prettierd" },
  },
  formatters = {},
})

vim.keymap.set("n", "<leader>cf", function()
  conform.format({ lsp_fallback = true, timeout_ms = 5000 })
end)
