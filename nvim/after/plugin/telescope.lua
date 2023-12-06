local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', function() builtin.find_files({ hidden = true }) end, {})
-- vim.keymap.set('n', '<leader>gf', function() builtin.git_files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>r', function() builtin.live_grep({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>g', function() builtin.grep_string({ hidden = true }) end, {})
