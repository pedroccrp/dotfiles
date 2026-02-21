local wal_path = vim.fn.expand("~/.cache/wal/nvim.lua")
if vim.loop.fs_stat(wal_path) then
  pcall(dofile, wal_path)
end
