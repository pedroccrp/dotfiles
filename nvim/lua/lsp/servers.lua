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
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
})

setup("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".git",
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME .. "/lua",
          vim.fn.stdpath("config") .. "/lua",
        },
        checkThirdParty = false,
      },
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
  filetypes = { "dart" },
  root_markers = {
    "pubspec.yaml",
    ".git",
  },
})

setup("kotlin_lsp", {
  cmd = { "intellij-server", "--stdio" },
  filetypes = { "kotlin" },
  root_dir = function(bufnr, on_dir)
    local filename = vim.api.nvim_buf_get_name(bufnr)

    local root = vim.fs.root(filename, {
      "settings.gradle.kts",
      "settings.gradle",
    })

    while root do
      local parent = vim.fs.dirname(root)

      if parent == root then
        break
      end

      local parent_settings = vim.uv.fs_stat(parent .. "/settings.gradle.kts")
        or vim.uv.fs_stat(parent .. "/settings.gradle")

      if not parent_settings then
        break
      end

      root = parent
    end

    if root then
      on_dir(root)
    end
  end,
})

setup("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

setup("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    ".git",
  },
})

setup("yamlls", {
  cmd = { "yaml-language-server", "--stdio" },

  filetypes = {
    "yaml",
    "yaml.docker-compose",
    "yaml.gitlab",
    "yaml.helm-values",
  },

  root_markers = {
    ".git",
    ".yamllint",
    ".yamlfmt",
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yaml",
    ".prettierrc.yml",
    "package.json",
  },

  settings = {
    yaml = {
      validate = true,
      completion = true,
      hover = true,
      format = {
        enable = true,
      },
    },
  },
})
