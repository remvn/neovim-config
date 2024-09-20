return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
            },
            signs_staged = {
                add = { text = "+" },
                change = { text = "~" },
            },
            signcolumn = true,
            numhl = false,
        })
    end,
}
