return {
    "NvChad/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            filetypes = {
                "javascript",
                "typescript",
                "vue",
                "css",
                "lua",
                "go",
            },
            user_default_options = {
                names = false,
            },
        })
    end,
}
