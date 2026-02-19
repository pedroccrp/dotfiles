local helpers = require("helpers")

if helpers.is_remote_terminal() then return end

local copilot = helpers.safe_require("copilot")
local copilot_cmp = helpers.safe_require("copilot_cmp")

if not copilot or not copilot_cmp then return end

copilot.setup({
  copilot_node_command = "/usr/bin/node",
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    trigger_on_accept = true,
    keymap = {
      accept = "<C-y>",
      accept_line = "<C-Space>",
      accept_word = "<C-f>",
      next = "<M-j>",
      prev = "<M-k>",
      dismiss = "<C-q>",
    },
  },
})

copilot_cmp.setup()
