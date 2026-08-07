vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "jar://*",
  callback = function(args)
    local uri = args.match

    local jar_path, entry_path = uri:match("^jar://(.-)!/(.+)$")
    if not jar_path or not entry_path then
      vim.notify("Invalid JAR URI: " .. uri, vim.log.levels.ERROR)
      return
    end

    jar_path = vim.uri_decode(jar_path)

    local result = vim
      .system({
        "unzip",
        "-p",
        jar_path,
        entry_path,
      }, {
        text = true,
      })
      :wait()

    if result.code ~= 0 then
      vim.notify("Failed to read JAR entry:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
      return
    end

    local lines = vim.split(result.stdout or "", "\n", {
      plain = true,
    })

    vim.bo[args.buf].modifiable = true
    vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)

    vim.bo[args.buf].buftype = "nofile"
    vim.bo[args.buf].bufhidden = "wipe"
    vim.bo[args.buf].swapfile = false
    vim.bo[args.buf].modifiable = false
    vim.bo[args.buf].readonly = true

    vim.bo[args.buf].filetype = vim.filetype.match({
      filename = entry_path,
    }) or ""
  end,
})
