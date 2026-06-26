vim.filetype.add({
  extension = {
    tsx = "typescriptreact",
    jsx = "javascriptreact",
    pyw = "python",
    htm = "html",
    kt = "kotlin",
    gd = "gdscript",
    gdscript3 = "gdscript",
    -- "log" and "md" are handled by default, but you can add them if needed:
    log = "text",
  },
  filename = {
    ["tmux.conf"] = "tmux",
  },
})
