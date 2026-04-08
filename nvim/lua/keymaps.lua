vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<leader>e", ":", { desc = "Enter command mode" })

vim.keymap.set("n", "<leader>k", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>x", ":!xdg-open %<cr><cr>", { desc = "Open file externally" })
vim.keymap.set("n", "<leader>Q", ":%bdelete<CR>", { silent = true, desc = "Delete all active buffers" })

vim.keymap.set(
  "n",
  "yp",
  ":let @+=expand('%').':'.line('.')<CR>",
  { silent = true, desc = "Copy file path with line number" }
)

vim.keymap.set("", "gf", ":edit <cfile><CR>", { silent = true, desc = "Open file under cursor (create if missing)" })

vim.keymap.set("v", "<", "<gv", { silent = true, desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "Indent right and reselect" })

vim.keymap.set("v", "y", "myy`y", { silent = true, desc = "Yank without moving cursor" })
vim.keymap.set("v", "Y", "myY`y", { silent = true, desc = "Yank line without moving cursor" })

vim.keymap.set("n", "x", '"_x', { desc = "Delete without affecting registers" })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move up by display line" })
vim.keymap.set(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true, desc = "Move down by display line" }
)

vim.keymap.set("v", "p", '"_dP', { silent = true, desc = "Paste without overwriting register" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Increase window width" })

vim.keymap.set("i", "<A-j>", "<Esc>:move .+1<CR>==gi", { silent = true, desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi", { silent = true, desc = "Move line up" })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", { silent = true, desc = "Move selection up" })

vim.keymap.set("n", "<BS>", ":e#<CR>", { silent = true, desc = "Go to alternate buffer" })
