local use = require("packer").use
local helpers = require("helpers")

use({
  "akinsho/flutter-tools.nvim",
  cond = not helpers.is_remote_terminal(),
  requires = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
  config = true,
})

use("reisub0/hot-reload.vim")
