return {
    "NvChad/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            filetypes = {
                "lua",
                -- "javascript",
                -- "typescript",
                -- "vue",
                -- "css",
                -- "go",
            },
            user_default_options = {
                names = false,
            },
        })
    end,
}
