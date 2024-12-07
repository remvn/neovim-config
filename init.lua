-- disable netrw at startup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- remap, options
require("myconfig")

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "myconfig.plugins" },
        { import = "myconfig.plugins.lsp" },
    },
    change_detection = { notify = false },
    checker = { enabled = false },
})

-- -- Profiling nvim performance
-- local function start_profile()
--     require("plenary.profile").start("profile.log", { flame = true })
--     print("profiling started")
-- end
--
-- local function stop_profile()
--     require("plenary.profile").stop()
--     print("profiling stopped. output file is: profile.json")
-- end
-- vim.keymap.set("n", "<F1>", start_profile)
-- vim.keymap.set("n", "<F2>", stop_profile)
