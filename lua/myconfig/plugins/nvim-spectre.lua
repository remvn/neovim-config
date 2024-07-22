return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").toggle()<CR>', {
            desc = "Spectre: toggle",
        })
        vim.keymap.set(
            "n",
            "<leader>sw",
            '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
            {
                desc = "Spectre: search current word",
            }
        )
        vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
            desc = "Spectre: search current selection",
        })
        vim.keymap.set(
            "n",
            "<leader>sP",
            '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
            {
                desc = "Spectre: search on current file",
            }
        )
    end,
}
