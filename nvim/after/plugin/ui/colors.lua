local helpers = require("helpers")

local colorizer = helpers.safe_require("colorizer")
local rose_pine = helpers.safe_require("rose-pine")

if not colorizer or not rose_pine then return end

colorizer.setup()

rose_pine.setup({
    variant = "auto",
    dark_variant = "main",
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
    },

    styles = {
        bold = true,
        italic = false,
        transparency = true,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    palette = {
        moon = {
            base = '#000000',
            overlay = '#000000',
        },
    },

    highlight_groups = {
    },

    before_highlight = function(group, highlight, palette)
    end,
})

vim.cmd("colorscheme rose-pine-moon")

local function load_wal_colors()
    local colors_path = vim.fn.expand("~/.cache/wal/colors.json")
    if vim.fn.filereadable(colors_path) ~= 1 then
        return nil
    end

    local ok, data = pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(colors_path), "\n"))
    if not ok or type(data) ~= "table" then
        return nil
    end

    return data
end

local function get_wal_color(index, fallback)
    return vim.g["terminal_color_" .. index] or fallback
end

local function apply_wal_highlights()
    local wal = load_wal_colors()
    local bg = "none"
    local fg = wal and wal.special and wal.special.foreground or get_wal_color(15, "#ffffff")
    local muted = wal and wal.colors and wal.colors.color8 or get_wal_color(8, "#666666")
    local accent = wal and wal.colors and wal.colors.color4 or get_wal_color(4, "#8888ff")
    local warn = wal and wal.colors and wal.colors.color3 or get_wal_color(3, "#ffd75f")
    local error = wal and wal.colors and wal.colors.color1 or get_wal_color(1, "#ff5f5f")
    local ok = wal and wal.colors and wal.colors.color2 or get_wal_color(2, "#5fff87")
    local colorcolumn = wal and wal.colors and wal.colors.color0 or get_wal_color(0, "#111111")

    vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg, bg = bg })
    vim.api.nvim_set_hl(0, "SignColumn", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "LineNr", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = accent, bg = bg, bold = true })
    vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = bg })
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "TabLine", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "TabLineFill", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = colorcolumn })

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

    vim.api.nvim_set_hl(0, "String", { fg = ok, bg = bg })
    vim.api.nvim_set_hl(0, "Function", { fg = accent, bg = bg })
    vim.api.nvim_set_hl(0, "Keyword", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "Type", { fg = get_wal_color(6, "#88dddd"), bg = bg })
    vim.api.nvim_set_hl(0, "Comment", { fg = muted, bg = bg })
    vim.api.nvim_set_hl(0, "Constant", { fg = warn, bg = bg })
    vim.api.nvim_set_hl(0, "Number", { fg = warn, bg = bg })
end

local wal_path = vim.fn.expand("~/.config/nvim/wal.lua")
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
