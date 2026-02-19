local ok, _ = pcall(vim.cmd.colorscheme, "rose-pine-moon")
if not ok then
  vim.notify("Rose Pine colorscheme not found")
end
