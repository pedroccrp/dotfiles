local use = require("packer").use

use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
use("nvim-treesitter/nvim-treesitter-context")

use("hrsh7th/nvim-cmp")
use("hrsh7th/cmp-buffer")
use("hrsh7th/cmp-path")
use("hrsh7th/cmp-nvim-lsp")

use("L3MON4D3/LuaSnip")
use("saadparwaiz1/cmp_luasnip")
use("rafamadriz/friendly-snippets")

use({
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  requires = {
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  },
})

use({
  "williamboman/mason.nvim",
  run = function()
    pcall(vim.cmd, "MasonUpdate")
  end,
})

use("tamago324/nlsp-settings.nvim")

use("neovim/nvim-lspconfig")
use("williamboman/mason-lspconfig.nvim")

use("stevearc/conform.nvim")
use("zapling/mason-conform.nvim")

use("onsails/lspkind.nvim")
use("gbrlsnchs/telescope-lsp-handlers.nvim")
