local M = {}

function M.log_skip(module)
  vim.notify(module .. " not found, skipping setup", vim.log.levels.DEBUG)
end

function M.safe_require(module)
  local ok, _ = pcall(require, module)
  if not ok then
    M.log_skip(module)
    return nil
  end
  return require(module)
end

function M.is_remote_terminal()
  return vim.env.SSH_CLIENT ~= nil
      or vim.env.SSH_TTY ~= nil
      or vim.env.SSH_CONNECTION ~= nil
end

return M
