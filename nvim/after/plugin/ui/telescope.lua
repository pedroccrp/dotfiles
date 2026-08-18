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
    file_ignore_patterns = {
      "^.git/",
      "/.git/",
      "^node_modules/",
      "/node_modules/",
      "^log/",
      "/log/",
      "^tmp/",
      "/tmp/",
      "vendor/",
      "%.cmd$",
      "%.o$",
      "%.a$",
      "%.so$",
      "%.ko$",
      "%.mod$",
      "%.order$",
      "%.symvers$",
      "^modules%.order$",
      "^Module%.symvers$",
      "^%.tmp_",
      "%.d$",
      "%.gcno$",
      "%.gcda$",
      "%.gd.uid$",
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

      "--glob=!node_modules/*",
      "--glob=!log/*",
      "--glob=!tmp/*",
      "--glob=!vendor/*",
      "--glob=!*.log",

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
        "--exclude",
        ".git",
        "--strip-cwd-prefix",
      },
    },
    git_changed_files = {
      find_command = {
        "git",
        "diff",
        "--name-only",
        "--relative",
      },
    },
    git_untracked_files = {
      find_command = {
        "git",
        "ls-files",
        "--others",
        "--exclude-standard",
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
  builtin.find_files({ hidden = true, no_ignore = true })
end, {})

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
