require("plugins.package-manager-plugins")
require("plugins.lsp-plugins")
require("plugins.flutter-plugins")
require("plugins.random-plugins")
require("plugins.git-plugins")
require("plugins.ai-plugins")

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("PackerInstall")
    vim.cmd("TSUpdate")
  end,
})
