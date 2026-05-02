local function setup(server, opts)
  opts = opts or {}
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end

setup("ruby_lsp", {
  cmd = { "ruby", "-S", "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
})

setup("bashls", {
  filetypes = { "sh", "bash", "zsh" },
})

setup("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

setup("gdscript", {
  cmd = { "nc", "localhost", "6005" },
  filetypes = { "gd", "gdscript", "gdscript3" },
  root_markers = { "project.godot", ".git" },
})

setup("dartls", {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  root_markers = { "pubspec.yaml", ".git" },
})

setup("kotlin_lsp", {
  filetypes = { "kotlin" },
  root_markers = {
    "settings.gradle.kts",
    "settings.gradle",
    "build.gradle.kts",
    "build.gradle",
    ".git",
  },
})

setup("rust_analyzer", {
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
})
