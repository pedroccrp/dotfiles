local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<CR>'] = select_one_or_multi,
      }
    }
  }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', function() builtin.find_files({ hidden = true }) end, {})
-- vim.keymap.set('n', '<leader>gf', function() builtin.git_files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>r', function() builtin.live_grep({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>gr', function() builtin.grep_string({ hidden = true }) end, {})
