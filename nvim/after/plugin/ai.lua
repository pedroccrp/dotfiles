-- Codeium
vim.g.codeium_disable_bindings = 1

vim.keymap.set("i", "<S-Tab>", function()
  return vim.fn["codeium#AcceptNextLine"]()
end, { expr = true, silent = true })
vim.keymap.set("i", "<C-Space>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })
vim.keymap.set("i", "<c-l>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })
vim.keymap.set("i", "<c-h>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })
vim.keymap.set("i", "<c-x>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })
