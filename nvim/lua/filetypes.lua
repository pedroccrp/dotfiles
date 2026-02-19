local filetype_map = {
    text = { 'txt', 'log' },
    markdown = { 'md', 'markdown' },
    python = { 'pyw' },
    javascript = { 'jsx' },
    javascriptreact = { 'jsx' },
    typescript = { 'tsx' },
    typescriptreact = { 'tsx' },
    html = { 'htm' },
    tmux = { 'tmux.conf' },
    gdscript = { 'gd', 'gdscript', 'gdscript3' },
}

local function set_filetype()
    local filename = vim.fn.expand('%:t')

    for filetype, extensions in pairs(filetype_map) do
        for _, ext in ipairs(extensions) do
          if filename:sub(-#ext) == ext then
            vim.bo.filetype = filetype
            return
          end
        end
    end
end

vim.api.nvim_create_autocmd("BufRead", {
    pattern = "*",
    callback = set_filetype,
})
