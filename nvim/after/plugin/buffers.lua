local bufferline = require('bufferline')

bufferline.setup {
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true
            }
        },
        right_mouse_command = false,
        left_mouse_command = false,
        middle_mouse_command = false,
        show_buffer_close_icons = false,
        always_show_bufferline = true,
    }
}

-- Buffer Movement
vim.keymap.set('n', 'J', ':bp<CR>')
vim.keymap.set('n', 'K', ':bn<CR>')
vim.keymap.set('n', '<leader>q', ':bd<CR>')
