local plugin = {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})
        harpoon:extend({
            UI_CREATE = function(cx)
                vim.opt.number = true
                vim.opt.relativenumber = true
                local opts = {
                    buffer = cx.bufnr,
                }

                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, opts)

                vim.keymap.set("n", "<C-s>", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, opts)

                vim.keymap.set("n", "<C-c>", function()
                    harpoon.ui:save()
                    harpoon.ui:close_menu()
                end, opts)

                vim.keymap.set("n", "q", function()
                    harpoon.ui:select_menu_item()
                end, opts)
            end,
        })

        local window_opts = {
            border = "rounded",
            title = " Harpoon ",
            ui_max_width = 70,
        }

        vim.keymap.set("n", "<leader>ma", function()
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<leader>ms", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), window_opts)
        end)
        vim.keymap.set("n", "<A-q>", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<A-w>", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<A-a>", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<A-s>", function()
            harpoon:list():select(4)
        end)
    end,
}

return plugin
