local helpers = require("helpers")

local Comment = helpers.safe_require("Comment")
local nvim_surround = helpers.safe_require("nvim-surround")
local nvim_ts_autotag = helpers.safe_require("nvim-ts-autotag")
local nvim_autopairs = helpers.safe_require("nvim-autopairs")

if Comment then
  Comment.setup()
end
if nvim_surround then
  nvim_surround.setup({})
end
if nvim_ts_autotag then
  nvim_ts_autotag.setup()
end
if nvim_autopairs then
  nvim_autopairs.setup()
end

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 100 })
  end,
})
