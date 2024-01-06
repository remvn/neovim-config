return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")

        config.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "javascript", "html", "typescript" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            -- indent = { enable = true },
        })
    end
}
