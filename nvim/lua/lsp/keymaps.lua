vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local buffer = event.buf
    local opts = { buffer = buffer }

    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    -- vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
    -- vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
    -- vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)

    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})
