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
      "^bin/",
      "^obj/",
      "/bin/",
      "/obj/",
      "^.git/",
      "/.git/",
    },
  },
})

telescope.load_extension("lsp_handlers")
telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({ hidden = true })
end, {})

vim.keymap.set("n", "<leader>fb", function()
  builtin.buffers({ hidden = true })
end, {})

vim.keymap.set("n", "<leader>fr", function()
  require("personal.live-grep-filtered").live_grep_filtered()
end, {})

vim.keymap.set("n", "<leader>fw", function()
  local word = vim.fn.expand("<cword>")
  builtin.live_grep({
    default_text = word,
    hidden = true,
  })
end, {})

vim.keymap.set("n", "<leader>fk", function()
  builtin.keymaps({ hidden = true })
end, {})

vim.keymap.set("n", "<leader>fh", function()
  builtin.help_tags()
end, {})
