vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "screenline" -- screenline,number
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.wildcharm = ("\t"):byte() -- macro recognize tab when using cmdline
vim.opt.spell = false
vim.opt.mousemodel = "extend"
-- vim.opt.colorcolumn = "80"
vim.opt.pumheight = 20

vim.opt.splitbelow = true -- put new windows below current
vim.opt.splitright = true -- put new windows right of current

vim.opt.ignorecase = true -- case insensitive searching
vim.opt.smartcase = true  -- case insensitive searching unless /C or capital in search
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.tabstop = 4      -- tab length (display)
vim.opt.softtabstop = 4  -- tab length (editing)
vim.opt.shiftwidth = 4   -- tab length when auto indent (>> or <<)
vim.opt.smartindent = true
-- autoindent, smarttab is default true
