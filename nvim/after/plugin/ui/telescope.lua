local helpers = require("helpers")

local telescope = helpers.safe_require("telescope")
if not telescope then
  return
end

telescope.setup({
  defaults = {
    path_display = {
      filename_first = {
        reverse_directories = true,
      },
    },
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        height = 0.95,
        preview_cutoff = 100,
        prompt_position = "bottom",
        width = 0.95,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",

      -- Large/generated directories
      "--glob=!node_modules/*",
      "--glob=!log/*",
      "--glob=!tmp/*",

      -- Build artifacts
      "--glob=!*.cmd",
      "--glob=!*.o",
      "--glob=!*.a",
      "--glob=!*.so",
      "--glob=!*.ko",
      "--glob=!*.mod",
      "--glob=!*.order",
      "--glob=!*.symvers",
      "--glob=!.tmp_*",
      "--glob=!*.gcno",
      "--glob=!*.gcda",
      "--glob=!*.gd.uid",

      "--max-filesize=1M",
    },
  },

  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type",
        "f",
        "--hidden",

        -- Large/generated directories
        "--exclude",
        ".git",
        "--exclude",
        "node_modules",
        "--exclude",
        "log",
        "--exclude",
        "tmp",

        -- Build artifacts
        "--exclude",
        "*.cmd",
        "--exclude",
        "*.o",
        "--exclude",
        "*.a",
        "--exclude",
        "*.so",
        "--exclude",
        "*.ko",
        "--exclude",
        "*.mod",
        "--exclude",
        "*.order",
        "--exclude",
        "*.symvers",
        "--exclude",
        ".tmp_*",
        "--exclude",
        "*.gcno",
        "--exclude",
        "*.gcda",
        "--exclude",
        "*.gd.uid",

        "--strip-cwd-prefix",
      },
    },
  },
})

telescope.load_extension("lsp_handlers")
telescope.load_extension("fzf")

local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({ hidden = true })
end, {})

vim.keymap.set("n", "<leader>fF", function()
  builtin.find_files({
    find_command = {
      "fd",
      "--type",
      "f",
      "--hidden",
      "--no-ignore",
      "--exclude",
      ".git",
      "--strip-cwd-prefix",
    },
  })
end)

vim.keymap.set("n", "<leader>fb", function()
  builtin.buffers()
end, {})

vim.keymap.set("n", "<leader>fr", function()
  require("personal.live-grep-filtered").live_grep_filtered()
end, {})

vim.keymap.set("n", "<leader>fw", function()
  local word = vim.fn.expand("<cword>")
  builtin.live_grep({ default_text = word })
end, {})

vim.keymap.set("n", "<leader>fk", function()
  builtin.keymaps({ only_buf = true })
end, {})

vim.keymap.set("n", "<leader>fh", function()
  builtin.help_tags()
end, {})

vim.keymap.set("n", "<leader>fm", function()
  builtin.marks()
end, {})

vim.keymap.set("n", "<leader>fg", function()
  pickers
    .new({}, {
      prompt_title = "Changed Files",
      finder = finders.new_oneshot_job({ "git", "diff", "--name-only", "--relative" }, {}),
      sorter = sorters.get_fuzzy_file(),
      previewer = previewers.git_file_diff.new({}),
    })
    :find()
end)

vim.keymap.set("n", "<leader>fG", function()
  require("telescope.builtin").find_files({
    find_command = {
      "git",
      "ls-files",
      "--others",
      "--exclude-standard",
    },
  })
end)
