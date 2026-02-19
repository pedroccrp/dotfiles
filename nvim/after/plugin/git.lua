local helpers = require("helpers")

-- Fugitive
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gs", ":Git status<CR>")

-- Gutter
vim.keymap.set("n", "<leader>hs", ":GitGutterStageHunk<CR>")
vim.keymap.set("n", "<leader>hr", ":GitGutterUndoHunk<CR>")
vim.keymap.set("n", "<leader>gn", ":GitGutterNextHunk<CR>")
vim.keymap.set("n", "<leader>gp", ":GitGutterPrevHunk<CR>")

local git_conflict = helpers.safe_require("git-conflict")
local gitsigns = helpers.safe_require("gitsigns")

if not git_conflict or not gitsigns then return end

git_conflict.setup()

gitsigns.setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
})
