require("plugins.package-manager-plugins")
require("plugins.core")
require("plugins.ui")
require("plugins.navigation")
require("plugins.editing")
require("plugins.utils")
require("plugins.git-plugins")
require("plugins.ai-plugins")

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("PackerInstall")
    vim.cmd("TSUpdate")
  end,
})
