local use = require('packer').use

use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
use('nvim-treesitter/nvim-treesitter-context')

use('hrsh7th/nvim-cmp')
use('hrsh7th/cmp-buffer')
use('hrsh7th/cmp-path')
use('hrsh7th/cmp-nvim-lsp')

use('L3MON4D3/LuaSnip')
use('saadparwaiz1/cmp_luasnip')
use('rafamadriz/friendly-snippets')

use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  requires = {
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  }
}

use {
  'stevearc/conform.nvim',
  lazy = false,
  opts = { notify_on_error = false },
}

use("nvimtools/none-ls.nvim")

use {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
  end,
}

use('onsails/lspkind.nvim')
use('gbrlsnchs/telescope-lsp-handlers.nvim')
