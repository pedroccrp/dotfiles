local helpers = require("helpers")

if helpers.is_remote_terminal() then return end

local cmp_nvim_lsp = helpers.safe_require("cmp_nvim_lsp")
local telescope = helpers.safe_require("telescope")

if not cmp_nvim_lsp or not telescope then return end

vim.lsp.config("ruby_lsp", {
  cmd = { "bundle", "exec", "ruby-lsp" },
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

vim.lsp.config("gdscript", {
  cmd = { "nc", "localhost", "6005" },
  filetypes = { "gd", "gdscript", "gdscript3" },
  root_markers = { "project.godot", ".git" },
})
vim.lsp.enable("gdscript")

vim.lsp.config("angularls", {
  cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations",
    vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
    "--ngProbeLocations",
    vim.fn.getcwd(),
  },
  root_markers = { "angular.json", "project.json" },
})
vim.lsp.enable("angularls")

vim.lsp.config("dartls", {
  cmd = { "/usr/bin/dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_markers = { "pubspec.yaml", ".git" },
})
vim.lsp.enable("dartls")

vim.diagnostic.config({
  signs = true,
})

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local buffer = event.buf
    local opts = { buffer = buffer }

    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end

    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
    vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
    vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)

    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
vim.lsp.config("*", { capabilities = capabilities })
