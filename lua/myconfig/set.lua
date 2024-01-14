vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case insensitive searching unless /C or capital in search

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "screenline"
vim.opt.termguicolors = true
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.wrap = false
-- vim.opt.colorcolumn = "80"

-- disable netrw at start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
