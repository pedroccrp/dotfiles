local use = require("packer").use

use({
  "akinsho/flutter-tools.nvim",
  requires = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
  config = true,
})

use("reisub0/hot-reload.vim")
