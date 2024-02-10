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

-- local branch_watcher = augroup("BranchWatcher", { clear = true })
-- autocmd('User', {
--     group = branch_watcher,
--     pattern = 'FugitiveChanged',
--     callback = function()
--         print("git changed ")
--         vim.cmd('checktime')
--     end,
-- })
