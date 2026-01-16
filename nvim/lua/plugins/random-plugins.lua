local use = require("packer").use

-- Movement
use("easymotion/vim-easymotion")
use("chentoast/marks.nvim")

-- Formatting
use({ "cappyzawa/trim.nvim" })

-- FZF
use({
  "nvim-telescope/telescope-fzf-native.nvim",
  run = "make",
})
use({
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/plenary.nvim" },
  },
})
use({ "axkirillov/easypick.nvim", requires = "nvim-telescope/telescope.nvim" })

-- Color Schemes
use("rose-pine/neovim")

-- Buffer and Status Lines
use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })
use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })
use({ "roobert/bufferline-cycle-windowless.nvim", requires = { { "akinsho/bufferline.nvim" } } })

-- File Explorer
use({
  "nvim-tree/nvim-tree.lua",
  requires = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({})
  end,
})

use({
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  requires = { { "nvim-lua/plenary.nvim" } },
})

-- Code Editing
use("numToStr/Comment.nvim")
use({ "kylechui/nvim-surround", tag = "*" })
use({
  "smoka7/multicursors.nvim",
  requires = {
    "smoka7/hydra.nvim",
  },
})

-- Terminal Integration
use("alexghergh/nvim-tmux-navigation")

-- Other
use("nvim-tree/nvim-web-devicons")
use("norcalli/nvim-colorizer.lua")
use("windwp/nvim-ts-autotag")
use("windwp/nvim-autopairs")
use({
  "folke/noice.nvim",
  requires = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
})

use("mbbill/undotree")

-- Indent Lines and Bracket Colors
use("lukas-reineke/indent-blankline.nvim")

use("folke/which-key.nvim")

-- Scrollbar
use("petertriho/nvim-scrollbar")

-- Markdown
use("OXY2DEV/markview.nvim")
