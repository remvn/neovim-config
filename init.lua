-- disable netrw at startup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("myconfig")
require("lazy").setup({
    { import = "myconfig.plugins" },
    { import = "myconfig.plugins.lsp" },
}, {
    change_detection = {
        notify = false,
    },
})

-- Profiling nvim performance
local function start_profile()
    require("plenary.profile").start("profile.log", { flame = true })
    print("profiling started")
end

local function stop_profile()
    require("plenary.profile").stop()
    print("profiling stopped. output file is: profile.json")
end

vim.keymap.set("n", "<F1>", start_profile)
vim.keymap.set("n", "<F2>", stop_profile)
