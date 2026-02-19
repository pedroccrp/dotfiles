-- Git plugins: fugitive, gitsigns, gitgutter, git-conflict
-- All these load on both local and server
return {
  -- Fugitive (vim Fugitive)
  "tpope/vim-fugitive",

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")
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
        watch_gitdir = { follow_files = true },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
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

      -- Keymaps
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
      vim.keymap.set("n", "<leader>gs", ":Git status<CR>")
      vim.keymap.set("n", "<leader>hs", ":GitGutterStageHunk<CR>")
      vim.keymap.set("n", "<leader>hr", ":GitGutterUndoHunk<CR>")
      vim.keymap.set("n", "<leader>gn", ":GitGutterNextHunk<CR>")
      vim.keymap.set("n", "<leader>gp", ":GitGutterPrevHunk<CR>")
    end,
  },

  -- GitGutter
  "airblade/vim-gitgutter",

  -- Git conflict
  {
    "akinsho/git-conflict.nvim",
    config = function()
      local git_conflict = require("git-conflict")
      git_conflict.setup()
    end,
  },
}
