local navic = require("nvim-navic")

navic.setup({
  highlight = true,
  separator = " > ",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, args.buf)
    end
  end,
})

vim.o.winbar = string.rep(" ", 0) .. "%{%v:lua.require'nvim-navic'.get_location()%}"

vim.api.nvim_set_hl(0, "WinBar", { link = "BufferLineFill" })
vim.api.nvim_set_hl(0, "WinBarNC", { link = "BufferLineFill" })
