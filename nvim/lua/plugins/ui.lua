local use = require("packer").use

use({
  "nvim-telescope/telescope.nvim",
  requires = { "nvim-lua/plenary.nvim" },
})
use({
  "nvim-telescope/telescope-fzf-native.nvim",
  run = "make",
})

use({ "axkirillov/easypick.nvim", requires = "nvim-telescope/telescope.nvim" })

use({
  "nvim-tree/nvim-tree.lua",
  requires = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({})
  end,
})

use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })
use({ "roobert/bufferline-cycle-windowless.nvim", requires = { "akinsho/bufferline.nvim" } })

use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })

use({
  "folke/noice.nvim",
  requires = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
})

use("nvim-tree/nvim-web-devicons")

use("petertriho/nvim-scrollbar")

use("OXY2DEV/markview.nvim")

use("cappyzawa/trim.nvim")
