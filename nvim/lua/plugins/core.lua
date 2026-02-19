-- Core plugins: LSP, completion, treesitter, formatting
-- All these load on both local and server
return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")
      local treesitter_config = require("nvim-treesitter.config")

      treesitter.setup({
        ensure_installed = {
          "vimdoc", "vim", "query", "regex", "javascript", "typescript",
          "c", "kotlin", "python", "lua", "rust", "ruby", "markdown", "markdown_inline",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },

  -- Indent Blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local ibl = require("ibl")
      local ibl_hooks = require("ibl.hooks")

      ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#333333", nocombine = true })
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#dddddd", bold = true, nocombine = true })
      end)

      ibl.setup({
        indent = { char = "│", highlight = { "IblIndent" } },
        scope = { enabled = true, highlight = { "IblScope" }, show_start = false, show_end = false },
      })

      ibl_hooks.register(ibl_hooks.type.SCOPE_HIGHLIGHT, ibl_hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  -- Navigation symbols
  "SmiteshP/nvim-navic",

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp",

  -- Snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",

  -- LSP
  "neovim/nvim-lspconfig",

  -- Mason - only load locally (not on SSH)
  {
    "williamboman/mason.nvim",
    cond = not is_remote_terminal(),
    config = function()
      local mason = require("mason")
      local mason_tool_installer = require("mason-tool-installer")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({})

      mason_tool_installer.setup({
        ensure_installed = { "gdtoolkit", "prettierd" },
        run_on_start = true,
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "dockerls", "jsonls", "ruby_lsp", "sqlls", "eslint",
          "rust_analyzer", "bashls", "lua_ls", "kotlin_lsp",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cond = not is_remote_terminal(),
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cond = not is_remote_terminal(),
  },

  -- Conform (formatting)
  {
    "stevearc/conform.nvim",
    config = function()
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
          gdscript = { "gdformat" },
          typescript = { "prettierd", "prettier", stop_after_first = true },
        },
        formatters = {
          gdformat = {
            command = "gdformat",
            args = { "-", "--use-spaces=4", "--line-length=120" },
            stdin = true,
          },
        },
      })
      vim.keymap.set("n", "<leader>cf", function()
        conform.format({ lsp_fallback = true, timeout_ms = 5000 })
      end)
    end,
  },

  -- LSP utilities
  "onsails/lspkind.nvim",
  "gbrlsnchs/telescope-lsp-handlers.nvim",
}
