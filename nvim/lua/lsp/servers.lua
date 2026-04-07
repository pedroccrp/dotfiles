vim.lsp.config("ruby_lsp", {
  cmd = { "ruby", "-S", "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
})

vim.lsp.config("bashls", {
  filetypes = { "sh", "bash", "zsh" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
  filetypes = { "lua" },
})

vim.lsp.config("gdscript", {
  cmd = { "nc", "localhost", "6005" },
  filetypes = { "gd", "gdscript", "gdscript3" },
  root_markers = { "project.godot", ".git" },
})

vim.lsp.config("dartls", {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_markers = { "pubspec.yaml", ".git" },
})

vim.lsp.enable("ruby_lsp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("gdscript")
vim.lsp.enable("dartls")
