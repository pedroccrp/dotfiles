vim.pack.add({
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/airblade/vim-gitgutter",
  { src = "https://github.com/akinsho/git-conflict.nvim", version = vim.version.range("*") },
}, { confirm = false })
