local helpers = require("helpers")

local twilight = helpers.safe_require("twilight")
local zen = helpers.safe_require("zen-mode")

if not twilight or not zen then
  return
end

twilight.setup({})

zen.setup({
  window = {
    backdrop = 0.95,
    width = 130,
  },
  plugins = {
    twilight = {
      enabled = true,
    },
    gitsigns = {
      enabled = true,
    },
  },
})

local disabled = {
  oil = true,
  help = true,
  alpha = true,
  lazy = true,
  mason = true,
  qf = true,
}

local function toggle_zen()
  if disabled[vim.bo.filetype] then
    vim.notify("Zen Mode is not available for " .. vim.bo.filetype .. " buffers.", vim.log.levels.WARN)
    return
  end

  vim.cmd("ZenMode")
end

vim.keymap.set("n", "<leader>z", toggle_zen, {
  desc = "Zen Mode",
})
