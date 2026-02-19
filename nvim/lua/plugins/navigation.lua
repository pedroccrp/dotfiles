-- Navigation plugins: harpoon, aerial, easymotion, marks
-- All these load on both local and server
return {
  -- Easymotion
  "easymotion/vim-easymotion",

  -- Easypick
  {
    "axkirillov/easypick.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      local easypick = require("easypick")
      local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
      local base_branch = vim.fn.system(get_default_branch) or "master"

      easypick.setup({
        pickers = {
          {
            name = "changed_files",
            command = "git diff --name-only --relative",
            previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
          },
          {
            name = "conflicts",
            command = "git diff --name-only --diff-filter=U --relative",
            previewer = easypick.previewers.file_diff(),
          },
        },
      })
      vim.keymap.set("n", "<leader>fg", "<cmd>Easypick changed_files<CR>", {})
    end,
  },

  -- Marks
  {
    "chentoast/marks.nvim",
    config = function()
      local marks = require("marks")
      marks.setup({
        default_mappings = true,
        builtin_marks = {},
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 150,
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        excluded_filetypes = {},
        excluded_buftypes = {},
        mappings = {},
      })
    end,
  },

  -- Aerial
  {
    "stevearc/aerial.nvim",
    config = function()
      local aerial = require("aerial")
      aerial.setup({ keymaps = { ["<TAB>"] = "actions.scroll" } })
      vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>")
    end,
  },

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local harpoon = require("harpoon")
      local telescope = require("telescope")
      local telescope_config = require("telescope.config")

      harpoon:setup({
        settings = { save_on_toggle = true, save_on_ui_close = true },
      })

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

      local conf = telescope_config.values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end
        telescope.pickers.new({}, {
          prompt_title = "Harpoon",
          finder = telescope.finders.new_table({ results = file_paths }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end
      vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    end,
  },
}
