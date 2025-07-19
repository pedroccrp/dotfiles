require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
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
    "kotlin",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

local base = {
  "RainbowRedBase",
  "RainbowYellowBase",
  "RainbowBlueBase",
  "RainbowOrangeBase",
  "RainbowGreenBase",
  "RainbowVioletBase",
  "RainbowCyanBase",
}

local highlight = {
  "RainbowRedHighlight",
  "RainbowYellowHighlight",
  "RainbowBlueHighlight",
  "RainbowOrangeHighlight",
  "RainbowGreenHighlight",
  "RainbowVioletHighlight",
  "RainbowCyanHighlight",
}

local hooks = require("ibl.hooks")
local base_blend = 100

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRedBase", { fg = "#B4637A", blend = blend }) -- muted rose
  vim.api.nvim_set_hl(0, "RainbowYellowBase", { fg = "#C4A463", blend = blend }) -- dusty yellow
  vim.api.nvim_set_hl(0, "RainbowBlueBase", { fg = "#7AA2F7", blend = blend }) -- soft navy
  vim.api.nvim_set_hl(0, "RainbowOrangeBase", { fg = "#D8875F", blend = blend }) -- burnt peach
  vim.api.nvim_set_hl(0, "RainbowGreenBase", { fg = "#8FB573", blend = blend }) -- forest mist
  vim.api.nvim_set_hl(0, "RainbowVioletBase", { fg = "#B68ACB", blend = blend }) -- dull lilac
  vim.api.nvim_set_hl(0, "RainbowCyanBase", { fg = "#74C7C7", blend = blend }) -- gentle cyan

  vim.api.nvim_set_hl(0, "RainbowRedHighlight", { fg = "#F38BA8" })
  vim.api.nvim_set_hl(0, "RainbowYellowHighlight", { fg = "#F9E2AF" })
  vim.api.nvim_set_hl(0, "RainbowBlueHighlight", { fg = "#89B4FA" })
  vim.api.nvim_set_hl(0, "RainbowOrangeHighlight", { fg = "#FAB387" })
  vim.api.nvim_set_hl(0, "RainbowGreenHighlight", { fg = "#A6E3A1" })
  vim.api.nvim_set_hl(0, "RainbowVioletHighlight", { fg = "#DDB6F2" })
  vim.api.nvim_set_hl(0, "RainbowCyanHighlight", { fg = "#94E2D5" })
end)

vim.g.rainbow_delimiters = {
  strategy = {
    [""] = "rainbow-delimiters.strategy.global",
    vim = "rainbow-delimiters.strategy.local",
  },
  query = {
    [""] = "rainbow-delimiters",
    lua = "rainbow-blocks",
  },
  priority = {
    [""] = 110,
    lua = 210,
  },
  highlight = base,
}

require("ibl").setup({
  indent = { highlight = base,  },
  scope = { highlight = highlight },
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
