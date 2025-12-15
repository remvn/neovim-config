return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")

        ---@diagnostic disable-next-line: missing-fields
        config.setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "go",
                "javascript",
                "typescript",
                "html",
                "css",
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            -- indent = { enable = true },
        })
    end,
}
