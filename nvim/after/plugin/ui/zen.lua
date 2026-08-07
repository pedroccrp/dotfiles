local helpers = require("helpers")

local twilight = helpers.safe_require("twilight")
local zen = helpers.safe_require("zen-mode")

if not twilight or not zen then
  return
end

twilight.setup({})

zen.setup({
  window = {
    backdrop = 0.95,
    width = 130,
  },
  plugins = {
    twilight = {
      enabled = true,
    },
    gitsigns = {
      enabled = true,
    },
  },
})

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", {
  desc = "Zen Mode",
})
