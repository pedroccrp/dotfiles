vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>ve', ':e ~/.config/nvim/init.lua<CR>', { silent = true })
-- vim.keymap.set('n', '<leader>vs', ':source ~/.config/nvim/init.lua<CR>', { silent = true })

vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>', { silent = true })

vim.keymap.set('n', 'yp', ':let @+=expand(\'%\').\':\'.line(\'.\')<CR>', { silent = true })

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>', { silent = true })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y', { silent = true })
vim.keymap.set('v', 'Y', 'myY`y', { silent = true })

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Paste replace visual selection without copying it
vim.keymap.set('v', 'p', '"_dP', { silent = true })

-- Open the current file in the default program (on Mac this should just be just `open`)
vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>')

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { silent = true })

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi', { silent = true })
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", { silent = true })
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", { silent = true })
