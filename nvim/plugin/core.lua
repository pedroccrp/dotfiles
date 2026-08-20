local helpers = require("helpers")

vim.pack.add({
  "https://github.com/SmiteshP/nvim-navic",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/onsails/lspkind.nvim",
  "https://github.com/gbrlsnchs/telescope-lsp-handlers.nvim",
  "https://github.com/stevearc/conform.nvim",
}, { confirm = false })

if not helpers.is_remote_terminal() then
  vim.pack.add({
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  }, { confirm = false })
end
