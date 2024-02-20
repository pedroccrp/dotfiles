local use = require('packer').use

-- Package Manager
use('wbthomason/packer.nvim')

-- Movement
use('easymotion/vim-easymotion')

-- Formatting
use({ "cappyzawa/trim.nvim" })

-- LSP and Code Highlight
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
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'L3MON4D3/LuaSnip' }
  }
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

-- FZF
use {
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/plenary.nvim' }
  }
}

-- Color Schemes
-- use('morhetz/gruvbox')
use('folke/tokyonight.nvim')

-- Git
use('tpope/vim-fugitive')
use('lewis6991/gitsigns.nvim')
use('airblade/vim-gitgutter')
use { 'akinsho/git-conflict.nvim', tag = "*" }

-- Buffer and Status Lines
use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }

-- File Explorer
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require("nvim-tree").setup {}
  end
}

-- Scroll
use('karb94/neoscroll.nvim')

-- Code Editing
use('numToStr/Comment.nvim')
use({ "kylechui/nvim-surround", tag = "*" })
use {
  'smoka7/multicursors.nvim',
  requires = {
    'smoka7/hydra.nvim',
  },
}

-- Terminal Integration
use('voldikss/vim-floaterm')
use("alexghergh/nvim-tmux-navigation")

-- Other
use('nvim-tree/nvim-web-devicons')
use('norcalli/nvim-colorizer.lua')
use('windwp/nvim-ts-autotag')
use('windwp/nvim-autopairs')
use {
  'folke/noice.nvim',
  requires = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify"
  }
}
