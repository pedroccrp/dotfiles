local helpers = require("helpers")

local navic = helpers.safe_require("nvim-navic")
local lualine = helpers.safe_require("lualine")

if not navic or not lualine then return end

local macro_reg = ""

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    macro_reg = vim.fn.reg_recording()
    lualine.refresh({ statusline = true })
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    macro_reg = ""
    lualine.refresh({ statusline = true })
  end,
})

local function macro_recording()
  if macro_reg == "" then
    return ""
  end
  return "RECORDING MACRO @" .. macro_reg
end

navic.setup({
  highlight = true,
  separator = " > ",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, args.buf)
    end
  end,
})

local function get_wal_color(index, fallback)
  return vim.g["terminal_color_" .. index] or fallback
end

local function build_lualine_theme()
  local fg = get_wal_color(15, "#ffffff")
  local bg = get_wal_color(0, "#111111")
  local accent = get_wal_color(4, "#8888ff")
  local muted = get_wal_color(8, "#666666")
  local warn = get_wal_color(3, "#ffd75f")
  local error = get_wal_color(1, "#ff5f5f")

  return {
    normal = {
      a = { fg = bg, bg = accent, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = fg, bg = "none" },
    },
    insert = {
      a = { fg = bg, bg = warn, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = fg, bg = "none" },
    },
    visual = {
      a = { fg = bg, bg = error, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = fg, bg = "none" },
    },
    replace = {
      a = { fg = bg, bg = error, gui = "bold" },
      b = { fg = fg, bg = bg },
      c = { fg = fg, bg = "none" },
    },
    inactive = {
      a = { fg = muted, bg = "none" },
      b = { fg = muted, bg = "none" },
      c = { fg = muted, bg = "none" },
    },
  }
end

local function setup_lualine()
  lualine.setup({
  options = {
    icons_enabled = true,
    theme = build_lualine_theme(),
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16,
      events = {
        "WinEnter",
        "BufEnter",
        "BufWritePost",
        "SessionLoadPost",
        "FileChangedShellPost",
        "VimResized",
        "Filetype",
        "CursorMoved",
        "CursorMovedI",
        "ModeChanged",
      },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filetype", "filename" },
    lualine_c = { navic.get_location },
    lualine_x = { "searchcount", "selectioncount" },
    lualine_y = { "diagnostics", "diff", "branch", macro_recording },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
  })
end

setup_lualine()

vim.api.nvim_create_autocmd("User", {
  pattern = "WalColorsUpdated",
  callback = function()
    setup_lualine()
  end,
})
