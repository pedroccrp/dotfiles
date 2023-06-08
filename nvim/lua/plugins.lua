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

