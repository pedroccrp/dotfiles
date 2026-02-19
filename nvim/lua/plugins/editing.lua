-- Editing plugins: Comment, surround, autopairs
-- All these load on both local and server
return {
  -- Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      local Comment = require("Comment")
      local nvim_surround = require("nvim-surround")
      local nvim_ts_autotag = require("nvim-ts-autotag")
      local nvim_autopairs = require("nvim-autopairs")

      Comment.setup()
      nvim_surround.setup({})
      nvim_ts_autotag.setup()
      nvim_autopairs.setup()

      vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight when yanking text",
        group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
        callback = function()
          vim.highlight.on_yank({ timeout = 100 })
        end,
      })
    end,
  },

  -- Surround
  { "kylechui/nvim-surround" },

  -- Autopairs
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",

  -- Trim (formatting on save)
  {
    "cappyzawa/trim.nvim",
    config = function()
      local trim = require("trim")
      trim.setup({
        ft_blocklist = { "markdown" },
        trim_on_write = true,
        trim_trailing = true,
        trim_first_line = false,
        trim_last_line = true,
      })
    end,
  },
}
