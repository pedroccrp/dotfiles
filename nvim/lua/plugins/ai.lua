-- AI plugins: copilot
-- Only load locally (not on SSH)
return {
  {
    "zbirenbaum/copilot.lua",
    cond = not is_remote_terminal(),
    config = function()
      local copilot = require("copilot")
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
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    cond = not is_remote_terminal(),
    config = function()
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup()
    end,
  },
}
