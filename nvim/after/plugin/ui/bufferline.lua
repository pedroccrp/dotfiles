local helpers = require("helpers")

local bufferline = helpers.safe_require("bufferline")
local bufferline_cycle_windowless = helpers.safe_require("bufferline-cycle-windowless")
local nvim_web_devicons = helpers.safe_require("nvim-web-devicons")

if not bufferline or not bufferline_cycle_windowless or not nvim_web_devicons then
  return
end

bufferline.setup({
  options = {
    color_icons = true,
    get_element_icon = function(element)
      local icon, _ = nvim_web_devicons.get_icon_by_filetype(element.filetype, { default = false })
      return icon
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
    right_mouse_command = false,
    left_mouse_command = false,
    middle_mouse_command = false,
    show_buffer_close_icons = false,
    always_show_bufferline = true,
  },
})

bufferline_cycle_windowless.setup({
  default_enabled = true,
})

vim.keymap.set("n", "<leader>q", ":bp | sp | bn | bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>Q", ":%bd|e#|bd#<CR>", { silent = true })

vim.api.nvim_set_keymap("n", "K", "<CMD>BufferLineCycleWindowlessNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "J", "<CMD>BufferLineCycleWindowlessPrev<CR>", { noremap = true, silent = true })
