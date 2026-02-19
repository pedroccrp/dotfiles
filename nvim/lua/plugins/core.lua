local use = require("packer").use
local helpers = require("helpers")

use({
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
})
use("SmiteshP/nvim-navic")

use("hrsh7th/nvim-cmp")
use("hrsh7th/cmp-buffer")
use("hrsh7th/cmp-path")
use("hrsh7th/cmp-nvim-lsp")

use("L3MON4D3/LuaSnip")
use("saadparwaiz1/cmp_luasnip")
use("rafamadriz/friendly-snippets")

use("neovim/nvim-lspconfig")
use({
  "williamboman/mason.nvim",
  cond = not helpers.is_remote_terminal(),
  run = function()
    pcall(vim.cmd, "MasonUpdate")
  end,
})
use({
  "williamboman/mason-lspconfig.nvim",
  cond = not helpers.is_remote_terminal(),
})
use({
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  cond = not helpers.is_remote_terminal(),
})

use("stevearc/conform.nvim")

use("onsails/lspkind.nvim")
use("gbrlsnchs/telescope-lsp-handlers.nvim")
