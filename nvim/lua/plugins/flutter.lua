-- Flutter plugins
-- Only load locally (not on SSH)
return {
  {
    "akinsho/flutter-tools.nvim",
    cond = not is_remote_terminal(),
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    config = function()
      local flutter_tools = require("flutter-tools")
      flutter_tools.setup({
        dev_log = { enabled = true },
      })
    end,
  },
  "reisub0/hot-reload.vim",
}
