local function prime_ts_projects(client)
  if client.name ~= "ts_ls" or not client.root_dir then
    return
  end

  local packages = vim.fn.glob(client.root_dir .. "/packages/*", false, true)

  for _, package_dir in ipairs(packages) do
    local files = vim.fn.glob(package_dir .. "/src/**/*.{ts,tsx}", false, true)

    local file = files[1]

    if file then
      local bufnr = vim.fn.bufadd(file)
      vim.fn.bufload(bufnr)
    end
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client then
      vim.schedule(function()
        prime_ts_projects(client)
      end)
    end
  end,
})
