local lsp_zero = require("lsp-zero")

lsp_zero.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = "",
    warn = "",
    hint = "",
    info = "",
  },
})

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  lsp_zero.default_keymaps({ buffer = bufnr })

  client.server_capabilities.semanticTokensProvider = nil

  vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
  vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
  vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
  vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, opts)

  vim.keymap.set("n", "gh", function()
    vim.lsp.buf.hover()
  end, opts)

  vim.keymap.set("n", "<leader>ws", function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, opts)
end)
