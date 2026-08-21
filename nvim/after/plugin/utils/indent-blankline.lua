local helpers = require("helpers")

local ibl = helpers.safe_require("ibl")
local ibl_hooks = helpers.safe_require("ibl.hooks")

if not ibl or not ibl_hooks then
  return
end

local hooks = ibl_hooks

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IblIndent", { fg = "#333333", nocombine = true })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#dddddd", bold = true, nocombine = true })
end)

ibl.setup({
  indent = {
    char = "│",
    highlight = { "IblIndent" },
  },
  scope = {
    enabled = true,
    highlight = { "IblScope" },
    show_start = false,
    show_end = false,
  },
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
