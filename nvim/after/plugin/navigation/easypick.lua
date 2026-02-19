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
