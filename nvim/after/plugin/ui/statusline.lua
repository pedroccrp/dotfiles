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

local function attach_navic(bufnr)
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
      lualine.refresh({ statusline = true })
      return
    end
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    attach_navic(args.buf)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    attach_navic(args.buf)
  end,
})

local function read_json(path)
  if vim.fn.filereadable(path) ~= 1 then
    return nil
  end

  local ok, data = pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(path), "\n"))
  if not ok or type(data) ~= "table" then
    return nil
  end

  return data
end

local function load_wal_derived()
  return read_json(vim.fn.expand("~/.cache/wal/colors-derived.json"))
end

local function build_lualine_theme()
  local wal = load_wal_derived()
  local fg = wal and wal.foreground or "#e0def4"
  local accent = wal and wal.accent or "#9ccfd8"
  local muted = wal and wal.muted or "#6e6a86"
  local warn = wal and wal.warn or "#f6c177"
  local error = wal and wal.urgent or "#eb6f92"
  local info = wal and wal.secondary or "#c4a7e7"

  return {
    normal = {
      a = { fg = fg, bg = accent, gui = "bold" },
      b = { fg = fg, bg = "none" },
      c = { fg = fg, bg = "none" },
      x = { fg = fg, bg = "none" },
      y = { fg = fg, bg = "none" },
      z = { fg = fg, bg = accent, gui = "bold" },
    },
    insert = {
      a = { fg = fg, bg = warn, gui = "bold" },
      b = { fg = fg, bg = "none" },
      c = { fg = fg, bg = "none" },
      x = { fg = fg, bg = "none" },
      y = { fg = fg, bg = "none" },
      z = { fg = fg, bg = warn, gui = "bold" },
    },
    visual = {
      a = { fg = fg, bg = error, gui = "bold" },
      b = { fg = fg, bg = "none" },
      c = { fg = fg, bg = "none" },
      x = { fg = fg, bg = "none" },
      y = { fg = fg, bg = "none" },
      z = { fg = fg, bg = error, gui = "bold" },
    },
    replace = {
      a = { fg = fg, bg = info, gui = "bold" },
      b = { fg = fg, bg = "none" },
      c = { fg = fg, bg = "none" },
      x = { fg = fg, bg = "none" },
      y = { fg = fg, bg = "none" },
      z = { fg = fg, bg = info, gui = "bold" },
    },
    inactive = {
      a = { fg = muted, bg = "none" },
      b = { fg = muted, bg = "none" },
      c = { fg = muted, bg = "none" },
      x = { fg = muted, bg = "none" },
      y = { fg = muted, bg = "none" },
      z = { fg = muted, bg = "none" },
    },
  }
end

local function navic_location()
  local ok, location = pcall(navic.get_location)
  if not ok or location == nil then
    return ""
  end
  return location
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
    lualine_c = {
      {
        navic_location,
        cond = function()
          return navic_location() ~= ""
        end,
        color = "Normal",
      },
    },
    lualine_x = { "searchcount", "selectioncount" },
    lualine_y = { "diagnostics", "diff", "branch", macro_recording },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
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
