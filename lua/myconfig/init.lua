require("myconfig.remap")
require("myconfig.options")

-- highlight when yanking
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", { clear = true })
autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- xdg-open browser issue
-- https://github.com/microsoft/WSL/issues/8892#issuecomment-1772972570 : add xdg-utils and wsl-utils
-- https://github.com/microsoft/WSL/issues/8952#issuecomment-1568212651 : fix WSLInterop missing
-- vim.api.nvim_create_user_command("Browse", "silent !xdg-open <q-args>", { nargs = 1 })
vim.api.nvim_create_user_command("Browse", function(opts)
    local cmd = opts.args:gsub("#", "\\#")
    vim.cmd("silent !xdg-open " .. cmd)
end, { nargs = 1 })
