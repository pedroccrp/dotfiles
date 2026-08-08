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

      "--glob=!node_modules/*",
      "--glob=!log/*",
      "--glob=!tmp/*",
      "--glob=!vendor/*",
      "--glob=!*.log",

      "--max-filesize=1M",
    },
  },
})

telescope.load_extension("lsp_handlers")
telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function()
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
