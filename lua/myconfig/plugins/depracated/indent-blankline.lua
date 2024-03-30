local plugin = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        require("ibl").setup({
            scope = {
                enabled = true,
                show_start = false,
                char = "▏",
            },
            indent = {
                char = " ",
            },
        })
    end,
}

return plugin
