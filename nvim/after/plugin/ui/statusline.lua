local helpers = require("helpers")

local navic = helpers.safe_require("nvim-navic")
local lualine = helpers.safe_require("lualine")

if not navic or not lualine then
  return
end

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

local function hex_to_rgb(hex)
  local value = (hex or "#000000"):gsub("#", "")
  if #value ~= 6 then
    return { 0, 0, 0 }
  end
  local r = tonumber(value:sub(1, 2), 16) or 0
  local g = tonumber(value:sub(3, 4), 16) or 0
  local b = tonumber(value:sub(5, 6), 16) or 0
  return {
    r / 255,
    g / 255,
    b / 255,
  }
end

local function luminance(rgb)
  local function adjust(c)
    if c <= 0.03928 then
      return c / 12.92
    end
    return ((c + 0.055) / 1.055) ^ 2.4
  end

  local r = adjust(rgb[1])
  local g = adjust(rgb[2])
  local b = adjust(rgb[3])
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

local function contrast_ratio(hex1, hex2)
  local l1 = luminance(hex_to_rgb(hex1)) + 0.05
  local l2 = luminance(hex_to_rgb(hex2)) + 0.05
  if l1 > l2 then
    return l1 / l2
  end
  return l2 / l1
end

local function readable_on_color(bg, preferred)
  local min_ratio = 4.5
  if preferred and contrast_ratio(preferred, bg) >= min_ratio then
    return preferred
  end

  local white = "#ffffff"
  local black = "#000000"
  if contrast_ratio(white, bg) >= contrast_ratio(black, bg) then
    return white
  end
  return black
end

local function build_lualine_theme()
  local wal = load_wal_derived()
  local fg = wal and wal.foreground or "#e0def4"
  local accent = wal and wal.accent or "#9ccfd8"
  local muted = wal and (wal.muted_text or wal.muted) or "#6e6a86"
  local muted_ui = wal and wal.muted or "#6e6a86"
  local warn = wal and wal.warn or "#f6c177"
  local error = wal and wal.urgent or "#eb6f92"
  local info = wal and wal.secondary or "#c4a7e7"
  local on_accent = readable_on_color(accent, wal and wal.on_accent)
  local on_warn = readable_on_color(warn, wal and wal.on_warn)
  local on_error = readable_on_color(error, wal and wal.on_urgent)
  local on_info = readable_on_color(info, wal and wal.on_secondary)
  local on_muted = readable_on_color(muted_ui, wal and wal.on_muted)

  return {
    normal = {
      a = { fg = on_accent, bg = accent, gui = "bold" },
      b = { fg = on_info, bg = info, gui = "bold" },
      c = { fg = fg, bg = "none" },
      x = { fg = fg, bg = "none" },
      y = { fg = fg, bg = "none" },
      z = { fg = on_accent, bg = accent, gui = "bold" },
    },
    insert = {
      a = { fg = on_warn, bg = warn, gui = "bold" },
      b = { fg = on_info, bg = info, gui = "bold" },
      c = { fg = fg, bg = "none" },
      x = { fg = fg, bg = "none" },
      y = { fg = fg, bg = "none" },
      z = { fg = on_warn, bg = warn, gui = "bold" },
    },
    visual = {
      a = { fg = on_error, bg = error, gui = "bold" },
      b = { fg = on_info, bg = info, gui = "bold" },
      c = { fg = fg, bg = "none" },
      x = { fg = fg, bg = "none" },
      y = { fg = fg, bg = "none" },
      z = { fg = on_error, bg = error, gui = "bold" },
    },
    replace = {
      a = { fg = on_info, bg = info, gui = "bold" },
      b = { fg = on_info, bg = info, gui = "bold" },
      c = { fg = fg, bg = "none" },
      x = { fg = fg, bg = "none" },
      y = { fg = fg, bg = "none" },
      z = { fg = on_info, bg = info, gui = "bold" },
    },
    inactive = {
      a = { fg = muted, bg = "none" },
      b = { fg = on_muted, bg = muted_ui, gui = "bold" },
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
      lualine_b = { { "filename", newfile_status = true, path = 1 } },
      lualine_c = {
        {
          navic_location,
          cond = function()
            return navic_location() ~= ""
          end,
          color = "Normal",
        },
      },
      lualine_x = { "searchcount", "selectioncount", macro_recording },
      lualine_y = { "diagnostics", "diff", "branch", "filetype" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { "filename" },
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
