local function navigate(direction, tmux_cmd)
  local current = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. direction)
  if vim.api.nvim_get_current_win() == current then
    vim.fn.system("tmux " .. tmux_cmd)
  end
end

vim.keymap.set("n", "<C-h>", function() navigate("h", "select-pane -L") end)
vim.keymap.set("n", "<C-j>", function() navigate("j", "select-pane -D") end)
vim.keymap.set("n", "<C-k>", function() navigate("k", "select-pane -U") end)
vim.keymap.set("n", "<C-l>", function() navigate("l", "select-pane -R") end)
