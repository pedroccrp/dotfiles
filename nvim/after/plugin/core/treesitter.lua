require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "vimdoc",
    "vim",
    "query",
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

local hooks = require("ibl.hooks")

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IblIndent", { fg = "#333333", nocombine = true })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#dddddd", bold = true, nocombine = true })
end)

require("ibl").setup({
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
