local helpers = require("helpers")

local harpoon = helpers.safe_require("harpoon")
local telescope = helpers.safe_require("telescope")
local telescope_config = helpers.safe_require("telescope.config")

if not harpoon or not telescope or not telescope_config then return end

harpoon:setup({
  settings = {
    save_on_toggle = true,
    save_on_ui_close = true,
  }
})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-S-P>", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
  harpoon:list():next()
end)
