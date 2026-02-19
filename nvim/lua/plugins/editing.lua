local use = require("packer").use

use("numToStr/Comment.nvim")
use({ "kylechui/nvim-surround", tag = "*" })
use({
  "smoka7/multicursors.nvim",
  requires = {
    "smoka7/hydra.nvim",
  },
})

use("windwp/nvim-autopairs")
use("windwp/nvim-ts-autotag")
