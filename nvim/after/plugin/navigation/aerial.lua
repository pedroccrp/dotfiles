require("aerial").setup({
  keymaps = {
    ["<TAB>"] = "actions.scroll",
  },
})

vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>")
