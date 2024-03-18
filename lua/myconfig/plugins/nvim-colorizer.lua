return {
    "NvChad/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            "javascript",
            "typescript",
            "vue",
            "css",
            "lua",
        })
    end,
}
