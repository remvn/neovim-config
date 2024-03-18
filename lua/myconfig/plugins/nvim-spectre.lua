return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local spectre = require("spectre")
        spectre.setup()

        vim.keymap.set("n", "<leader>S", function()
            spectre.toggle()
        end, {
            desc = "spectre: toggle",
        })

        vim.keymap.set("n", "<leader>sw", function()
            spectre.open_visual({ select_word = true })
        end, {
            desc = "spectre: search current word",
        })

        vim.keymap.set("v", "<leader>sw", function()
            spectre.open_visual()
        end, {
            desc = "spectre: search current word",
        })

        vim.keymap.set("v", "<leader>sp", function()
            spectre.open_file_search({ select_word = true })
        end, {
            desc = "spectre: search on current file",
        })
    end,
}
