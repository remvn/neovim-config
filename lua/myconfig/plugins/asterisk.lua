return {
    "haya14busa/vim-asterisk",
    config = function()
        -- * dont jump to next occurrence
        vim.keymap.set({ "n", "x" }, "*", "<Plug>(asterisk-z*)")
    end,
}
