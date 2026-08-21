vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    local changed = kind == "install" or kind == "update"

    if name == "nvim-treesitter" and changed then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.schedule(function()
        vim.cmd("TSUpdate")
      end)
    elseif name == "telescope-fzf-native.nvim" and changed then
      -- Synchronous: after/plugin loads the fzf extension right after this file.
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    elseif name == "mason.nvim" and changed then
      if not ev.data.active then
        vim.cmd.packadd("mason.nvim")
      end
      pcall(vim.cmd, "MasonUpdate")
    end
  end,
})
