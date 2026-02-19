local use = require("packer").use
local helpers = require("helpers")

use({
  "zbirenbaum/copilot.lua",
  cond = not helpers.is_remote_terminal(),
})
use({
  "zbirenbaum/copilot-cmp",
  cond = not helpers.is_remote_terminal(),
})
