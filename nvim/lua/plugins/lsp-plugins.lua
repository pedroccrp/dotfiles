local use = require('packer').use

use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
use('nvim-treesitter/nvim-treesitter-context')

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
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'L3MON4D3/LuaSnip' }
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
