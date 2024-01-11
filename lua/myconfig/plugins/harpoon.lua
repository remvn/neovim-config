return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
        local window_opts = {
            border = "rounded",
            title = " Harpoon ",
            ui_max_width = 70,
        }
        vim.keymap.set("n", "<A-1>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), window_opts) end)

        vim.keymap.set("n", "<A-q>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<A-w>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<A-a>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<A-s>", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<A-p>", function() harpoon:list():prev() end)
        -- vim.keymap.set("n", "<A-n>", function() harpoon:list():next() end)
    end
}
