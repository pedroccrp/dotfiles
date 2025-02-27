local bufferline = require("bufferline")

bufferline.setup({
  options = {
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

-- Buffer Movement
vim.keymap.set("n", "J", ":bp<CR>", { silent = true })
vim.keymap.set("n", "K", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", ":e#<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>Q", ":%bd|e#|bd#<CR>", { silent = true })
