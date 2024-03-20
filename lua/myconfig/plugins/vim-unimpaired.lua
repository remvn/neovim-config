return {
    "tpope/vim-unimpaired",
    config = function()
        vim.keymap.set("n", "[q", ":cprevious<cr>zz")
        vim.keymap.set("n", "]q", ":cnext<cr>zz")
    end,
}
