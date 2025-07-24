vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.spell = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.fillchars:append({ eob = ' ' })

vim.opt.mouse = 'a'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.clipboard = 'unnamedplus'

vim.opt.confirm = true
vim.opt.undofile = true

vim.opt.backup = true
vim.opt.backupdir:remove('.')
vim.opt.shortmess:append({ I = true })

vim.opt.wildmode = 'longest:full,full'
vim.opt.showmode = false

vim.opt.updatetime = 4001
vim.opt.redrawtime = 10000

vim.opt.signcolumn = 'yes:2'
vim.opt.colorcolumn = '80'

vim.opt.timeout = false
