return {
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local select_one_or_multi = function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          actions.close(prompt_bufnr)
          for _, j in pairs(multi) do
            if j.path ~= nil then
              vim.cmd(string.format("%s %s", "edit", j.path))
            end
          end
        else
          actions.select_default(prompt_bufnr)
        end
      end

      telescope.setup({
        defaults = {
          mappings = {
            i = { ["<CR>"] = select_one_or_multi },
            n = { ["<CR>"] = select_one_or_multi },
          },
          path_display = { filename_first = { reverse_directories = true } },
          file_ignore_patterns = { "^bin/", "^obj/", "/bin/", "/obj/", "^.git/", "/.git/" },
        },
      })

      telescope.load_extension("lsp_handlers")
      telescope.load_extension("fzf")
      telescope.load_extension("flutter")

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ft", function()
        telescope.extensions.flutter.commands()
      end, {})
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ hidden = true })
      end, {})
      vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers({ hidden = true })
      end, {})
      vim.keymap.set("n", "<leader>fr", function()
        require("personal.live-grep-filtered").live_grep_filtered()
      end, {})
      vim.keymap.set("n", "<leader>fk", function()
        local word = vim.fn.expand("<cword>")
        builtin.live_grep({ default_text = word, hidden = true })
      end, {})
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local nvim_tree = require("nvim-tree")
      nvim_tree.setup({
        git = { ignore = false },
        renderer = {
          highlight_opened_files = "none",
          group_empty = true,
          icons = { show = { folder_arrow = false } },
          indent_markers = { enable = true },
        },
        actions = { open_file = { quit_on_open = true } },
      })
      vim.cmd([[
        highlight NvimTreeIndentMarker guifg=#30323E
        augroup NvimTreeHighlights
          autocmd ColorScheme * highlight NvimTreeIndentMarker guifg=#30323E
        augroup end
      ]])
      vim.keymap.set("n", "<leader>n", ":NvimTreeFindFileToggle<CR>", { silent = true })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      local bufferline_cycle_windowless = require("bufferline-cycle-windowless")
      bufferline.setup({
        options = {
          offsets = { { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", separator = true } },
          right_mouse_command = false,
          left_mouse_command = false,
          middle_mouse_command = false,
          show_buffer_close_icons = false,
          always_show_bufferline = true,
        },
      })
      bufferline_cycle_windowless.setup({ default_enabled = true })
      vim.keymap.set("n", "<leader>o", ":e#<CR>", { silent = true })
      vim.keymap.set("n", "<leader>q", ":bp | sp | bn | bd<CR>", { silent = true })
      vim.keymap.set("n", "<leader>Q", ":%bd|e#|bd#<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "K", "<CMD>BufferLineCycleWindowlessNext<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "J", "<CMD>BufferLineCycleWindowlessPrev<CR>", { noremap = true, silent = true })
    end,
  },
  { "roobert/bufferline-cycle-windowless.nvim", dependencies = "akinsho/bufferline.nvim" },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local navic = require("nvim-navic")
      local lualine = require("lualine")

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
        if macro_reg == "" then return "" end
        return "RECORDING MACRO @" .. macro_reg
      end

      navic.setup({ highlight = true, separator = " > " })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, args.buf)
          end
        end,
      })

      lualine.setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = {}, winbar = {} },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000, refresh_time = 16 },
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
      })
    end,
  },

  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      local noice = require("noice")
      noice.setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },

  -- Colorscheme
  {
    "rose-pine/neovim",
    config = function()
      local rose_pine = require("rose-pine")
      rose_pine.setup({
        variant = "",
        dark_variant = "main",
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        enable = { terminal = true, legacy_highlights = true, migrations = true },
        styles = { bold = true, italic = false, transparency = true },
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
      })
    end,
  },

  -- Icons
  "nvim-tree/nvim-web-devicons",

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      local scrollbar = require("scrollbar")
      local scrollbar_gitsigns = require("scrollbar.handlers.gitsigns")
      scrollbar.setup()
      scrollbar_gitsigns.setup()
    end,
  },

  -- Markview
  "OXY2DEV/markview.nvim",

  -- Trim
  "cappyzawa/trim.nvim",
}
