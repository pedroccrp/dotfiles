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

return M
