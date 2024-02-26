local plugin = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        require("ibl").setup({
            scope = {
                show_start = false,
            },
            indent = {
                char = '▏'
            }
        })
    end
}

return {}
