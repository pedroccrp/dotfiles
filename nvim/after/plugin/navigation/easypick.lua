local helpers = require("helpers")

local easypick = helpers.safe_require("easypick")
if not easypick then
  return
end

easypick.setup({
  pickers = {
    {
      name = "changed_files",
      command = "git diff --name-only --relative",
      previewer = easypick.previewers.file_diff(),
    },
  },
})

vim.keymap.set("n", "<leader>fg", "<cmd>Easypick changed_files<CR>", {})
