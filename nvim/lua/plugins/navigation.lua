local use = require("packer").use

use("easymotion/vim-easymotion")
use("chentoast/marks.nvim")

use("stevearc/aerial.nvim")

use({
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  requires = { "nvim-lua/plenary.nvim" },
})
