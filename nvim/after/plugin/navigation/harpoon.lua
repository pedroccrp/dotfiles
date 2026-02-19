local helpers = require("helpers")

local harpoon = helpers.safe_require("harpoon")
local telescope = helpers.safe_require("telescope")
local telescope_config = helpers.safe_require("telescope.config")

if not harpoon or not telescope or not telescope_config then return end

harpoon:setup({
  settings = {
    save_on_toggle = true,
    save_on_ui_close = true,
  }
})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-S-P>", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
  harpoon:list():next()
end)

local conf = telescope_config.values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  telescope.pickers
    .new({}, {
      prompt_title = "Harpoon",
      finder = telescope.finders.new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

vim.keymap.set("n", "<leader>fh", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
