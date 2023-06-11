local use = require('packer').use

-- Package Manager
use('wbthomason/packer.nvim')

-- FZF
use {
    'nvim-telescope/telescope.nvim',
    requires = {
	    {'nvim-lua/plenary.nvim'}
    }
  }

-- LSP and Code Highlight
use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
use('nvim-treesitter/nvim-treesitter-context')

use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    {'neovim/nvim-lspconfig'},
    {
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'}
  }
}

-- Color Schemes
use('morhetz/gruvbox')

-- Git
use('tpope/vim-fugitive')

-- Buffers
use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}

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

-- Code Editting
use('numToStr/Comment.nvim')
use({ "kylechui/nvim-surround", tag = "*" })
-- Terminal Integration
use({
  'voldikss/vim-floaterm',
  config = function()
    require('user.plugins.floaterm')
  end,
})
