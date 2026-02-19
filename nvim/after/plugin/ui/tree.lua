local helpers = require("helpers")

local nvim_tree = helpers.safe_require("nvim-tree")
if not nvim_tree then return end

nvim_tree.setup({
  git = {
    ignore = false,
  },
  renderer = {
    highlight_opened_files = 'none',
    group_empty = true,
    icons = {
      show = {
        folder_arrow = false,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

vim.cmd([[
  highlight NvimTreeIndentMarker guifg=#30323E
  augroup NvimTreeHighlights
    autocmd ColorScheme * highlight NvimTreeIndentMarker guifg=#30323E
  augroup end
]])

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { silent = true })
