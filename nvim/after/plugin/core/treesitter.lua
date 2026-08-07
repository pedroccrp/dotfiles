local helpers = require("helpers")

local treesitter = helpers.safe_require("nvim-treesitter")
local ibl = helpers.safe_require("ibl")
local ibl_hooks = helpers.safe_require("ibl.hooks")

if not treesitter or not ibl or not ibl_hooks then
  return
end

local parsers = {
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
  "zsh",
  "bash",
  "go",
  "html",
  "css",
  "json",
  "yaml",
  "toml",
  "starlark",
}

treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterAutoInstall", {
    clear = true,
  }),

  callback = function(args)
    local filetype = vim.bo[args.buf].filetype

    if filetype == "" then
      return
    end

    local language = vim.treesitter.language.get_lang(filetype) or filetype
    local available = treesitter.get_available()

    -- Ignore synthetic plugin filetypes such as "notify".
    if not vim.tbl_contains(available, language) then
      return
    end

    local function start()
      if not vim.api.nvim_buf_is_valid(args.buf) then
        return
      end

      pcall(vim.treesitter.start, args.buf, language)
    end

    local installed = treesitter.get_installed()

    if vim.tbl_contains(installed, language) then
      start()
      return
    end

    treesitter.install({ language }):await(function()
      vim.schedule(start)
    end)
  end,
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
