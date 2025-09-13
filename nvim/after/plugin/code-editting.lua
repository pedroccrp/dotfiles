require("Comment").setup()
require("nvim-surround").setup({})
require('nvim-ts-autotag').setup()
require('nvim-autopairs').setup()

-- require("multicursors").setup({
--   DEBUG_MODE = false,
--   create_commands = true, -- create Multicursor user commands
--   updatetime = 50, -- selections get updated if this many milliseconds nothing is typed in the insert mode see :help updatetime
--   nowait = true, -- see :help :map-nowait
--   mode_keys = {
--     append = "a",
--     change = "c",
--     extend = "e",
--     insert = "i",
--   }, -- set bindings to start these modes
--   -- normal_keys = normal_keys,
--   -- insert_keys = insert_keys,
--   -- extend_keys = extend_keys,
--   -- see :help hydra-config.hint
--   hint_config = {
--     border = "none",
--     position = "bottom",
--   },
--   -- accepted values:
--   -- -1 true: generate hints
--   -- -2 false: don't generate hints
--   -- -3 [[multi line string]] provide your own hints
--   -- -4 fun(heads: Head[]): string - provide your own hints
--   generate_hints = {
--     normal = true,
--     insert = true,
--     extend = true,
--   },
-- })

-- vim.keymap.set("n", "<leader>m", ":MCstart<CR>", { silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("hihlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

-- Scrollbar
require("scrollbar").setup()
require("scrollbar.handlers.gitsigns").setup()
