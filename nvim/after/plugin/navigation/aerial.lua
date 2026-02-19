local helpers = require("helpers")

local aerial = helpers.safe_require("aerial")
if not aerial then return end

aerial.setup({
  keymaps = {
    ["<TAB>"] = "actions.scroll",
  },
})

vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>")
