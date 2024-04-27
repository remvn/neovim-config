return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local trouble = require("trouble")
        trouble.setup({
            use_diagnostic_signs = true,
            action_keys = {
                close = {},
                jump_close = { "q" },
                hover = "gh", -- opens a small popup with the full multiline message
            },
            signs = {
                other = "",
            },
        })

        vim.keymap.set("n", "<leader>ef", function()
            trouble.toggle()
        end)

        vim.keymap.set("n", "]e", function()
            trouble.next({ skip_groups = true, jump = true })
        end)
        vim.keymap.set("n", "[e", function()
            trouble.previous({ skip_groups = true, jump = true })
        end)

        -- #lsp-keymap
        vim.keymap.set("n", "<leader>wd", function()
            trouble.toggle("workspace_diagnostics")
        end)
        vim.keymap.set("n", "<leader>ld", function()
            trouble.toggle("document_diagnostics")
        end)
        vim.keymap.set("n", "gH", function()
            trouble.toggle("lsp_references")
        end)
        vim.keymap.set("n", "gd", function()
            trouble.toggle("lsp_definitions")
        end)
    end,
}
