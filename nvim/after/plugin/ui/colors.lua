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
        transparency = false,
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
