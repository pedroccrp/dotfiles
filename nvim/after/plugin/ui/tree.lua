local helpers = require("helpers")

local nvim_tree = helpers.safe_require("nvim-tree")
if not nvim_tree then
  return
end

nvim_tree.setup({
  view = {
    width = 80,
  },
  renderer = {
    highlight_opened_files = "name",
    group_empty = true,
    icons = {
      show = {
        folder_arrow = true,
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
  filters = {
    git_ignored = false,
    dotfiles = false,
    custom = {
      "\\.gd.uid$",
      "\\.cmd$",
      "\\.o$",
      "\\.ko$",
      "\\.mod$",
      "\\.order$",
      "\\.symvers$",
    },
  },
})

vim.cmd([[
  highlight NvimTreeIndentMarker guifg=#30323E
  augroup NvimTreeHighlights
    autocmd ColorScheme * highlight NvimTreeIndentMarker guifg=#30323E
  augroup end
]])

vim.keymap.set("n", "<leader>n", ":NvimTreeFindFileToggle<CR>", { silent = true })
