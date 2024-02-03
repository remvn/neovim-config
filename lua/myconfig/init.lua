require("myconfig.remap")
require("myconfig.set")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup('HighlightYank', { clear = true })
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

vim.opt.updatetime = 1000
local reload_buffer_group = augroup("AutoReloadBuffer", { clear = true })
autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
    group = reload_buffer_group,
    pattern = '*',
    command = 'checktime'
})
