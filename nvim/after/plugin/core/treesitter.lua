local helpers = require("helpers")

local treesitter = helpers.safe_require("nvim-treesitter")
local treesitter_configs = helpers.safe_require("nvim-treesitter.configs")
local ibl = helpers.safe_require("ibl")
local ibl_hooks = helpers.safe_require("ibl.hooks")

if not treesitter or not treesitter_configs or not ibl or not ibl_hooks then return end

treesitter_configs.setup({
  ensure_installed = {
    "vimdoc",
    "vim",
    "query",
    "regex",
    "javascript",
    "typescript",
    "c",
    "kotlin",
    "python",
    "lua",
    "rust",
    "ruby",
    "markdown",
    "markdown_inline",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

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
