local ok, telescope = pcall(require, "telescope.builtin")

local refs = ok and telescope.lsp_references or vim.lsp.buf.references
local defs = ok and telescope.lsp_definitions or vim.lsp.buf.definition
local impl = ok and telescope.lsp_implementations or vim.lsp.buf.implementation

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local buffer = event.buf
    local opts = { buffer = buffer }

    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.keymap.set("n", "grr", refs, opts)
    vim.keymap.set("n", "gd", defs, opts)
    vim.keymap.set("n", "gi", impl, opts)

    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})
