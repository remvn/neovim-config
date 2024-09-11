return {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
        vim.g.codeium_enabled = false
        vim.g.codeium_no_map_tab = 1

        vim.keymap.del("i", "<C-g>s")
        vim.keymap.del("i", "<C-g>S")
        vim.keymap.set("i", "<C-g>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
        vim.keymap.set("n", "<F2>", function()
            vim.g.codeium_enabled = not vim.g.codeium_enabled
        end)
    end,
}
