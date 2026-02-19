local helpers = require("helpers")

local Comment = helpers.safe_require("Comment")
local nvim_surround = helpers.safe_require("nvim-surround")
local nvim_ts_autotag = helpers.safe_require("nvim-ts-autotag")
local nvim_autopairs = helpers.safe_require("nvim-autopairs")

if not Comment or not nvim_surround or not nvim_ts_autotag or not nvim_autopairs then return end

Comment.setup()
nvim_surround.setup({})
nvim_ts_autotag.setup()
nvim_autopairs.setup()

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("hihlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})
