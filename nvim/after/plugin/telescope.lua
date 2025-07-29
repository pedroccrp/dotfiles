local select_one_or_multi = function(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require("telescope.actions").close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format("%s %s", "edit", j.path))
      end
    end
  else
    require("telescope.actions").select_default(prompt_bufnr)
  end
end

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<CR>"] = select_one_or_multi,
      },
      n = {
        ["<CR>"] = select_one_or_multi,
      },
    },
  },
})

telescope.load_extension("lsp_handlers")
telescope.load_extension("fzf")
telescope.load_extension("flutter")

vim.keymap.set("n", "<leader>ft", function()
  telescope.extensions.flutter.commands()
end, {})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({ hidden = true })
end, {})
vim.keymap.set("n", "<leader>fb", function()
  builtin.buffers({ hidden = true })
end, {})
vim.keymap.set("n", "<leader>fr", function()
  builtin.live_grep({ hidden = true })
end, {})
vim.keymap.set("n", "<leader>fk", function()
  local word = vim.fn.expand("<cword>")
  builtin.live_grep({
    default_text = word,
    hidden = true,
  })
end, {})
