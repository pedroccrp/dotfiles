local helpers = require("helpers")

vim.cmd("colorscheme default")

local fallback_palette = {
    background = "#191724",
    foreground = "#e0def4",
    muted = "#6e6a86",
    accent = "#9ccfd8",
    warn = "#f6c177",
    error = "#eb6f92",
    ok = "#9ccfd8",
    type = "#c4a7e7",
    ui_bg = "#26233a",
    ui_border = "#403d52",
}

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

local function apply_wal_highlights()
    local wal = load_wal_derived()
    local bg = "none"
    local bg_color = wal and wal.background or fallback_palette.background
    local fg = wal and wal.foreground or fallback_palette.foreground
    local muted = wal and wal.muted or fallback_palette.muted
    local accent = wal and wal.accent or fallback_palette.accent
    local warn = wal and wal.warn or fallback_palette.warn
    local error = fallback_palette.error
    local ok = wal and wal.secondary or fallback_palette.ok
    local ui_bg = wal and wal.ui_bg or fallback_palette.ui_bg
    local ui_border = wal and wal.ui_border or fallback_palette.ui_border
    local colorcolumn = ui_border
    local type_color = wal and wal.secondary or fallback_palette.type

    vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg, bg = ui_bg })
    vim.api.nvim_set_hl(0, "SignColumn", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "LineNr", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = accent, bg = bg, bold = true })
    vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = bg })
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "TabLine", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "TabLineFill", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = colorcolumn })
    vim.api.nvim_set_hl(0, "Pmenu", { fg = fg, bg = ui_bg })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = fg, bg = ui_border, bold = true })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = ui_bg })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = ui_border })

    vim.api.nvim_set_hl(0, "BufferLineFill", { bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = fg, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = fg, bg = bg, bold = true })
    vim.api.nvim_set_hl(0, "BufferLineTab", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineTabSelected", { fg = fg, bg = bg, bold = true })
    vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = accent, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineModified", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineError", { fg = error, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineWarning", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineInfo", { fg = ok, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = bg, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { fg = bg, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = bg, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineCloseButton", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = fg, bg = bg })
    vim.api.nvim_set_hl(0, "BufferLineCloseButtonVisible", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarHandle", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarSearch", { fg = accent, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarError", { fg = error, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarWarn", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarInfo", { fg = ok, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarHint", { fg = accent, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarGitAdd", { fg = ok, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarGitChange", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "ScrollbarGitDelete", { fg = error, bg = bg })

    vim.api.nvim_set_hl(0, "NotifyBackground", { bg = bg_color })

    vim.api.nvim_set_hl(0, "String", { fg = ok, bg = bg })
    vim.api.nvim_set_hl(0, "Function", { fg = accent, bg = bg })
    vim.api.nvim_set_hl(0, "Keyword", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "Type", { fg = type_color, bg = bg })
    vim.api.nvim_set_hl(0, "Comment", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "Constant", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "Number", { fg = warn, bg = bg })
end

local wal_path = vim.fn.expand("~/.cache/wal/nvim.lua")
local last_wal_mtime = 0

local function load_wal()
    if vim.fn.filereadable(wal_path) == 1 then
        pcall(dofile, wal_path)
    end
end

local function refresh_wal()
    local stat = vim.uv.fs_stat(wal_path)
    local mtime = stat and stat.mtime.sec or 0
    if mtime > last_wal_mtime then
        last_wal_mtime = mtime
        load_wal()
        apply_wal_highlights()
        local lualine = helpers.safe_require("lualine")
        if lualine then
            vim.api.nvim_exec_autocmds("User", { pattern = "WalColorsUpdated" })
            lualine.refresh({ statusline = true, tabline = true, winbar = true })
        end
    end
end

load_wal()
apply_wal_highlights()
refresh_wal()

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    callback = refresh_wal,
})
