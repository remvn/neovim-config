return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local trouble = require("trouble")
        trouble.setup()

        -- vim.keymap.set("n", "]e", function()
        --     trouble.next({ skip_groups = true, jump = true })
        -- end)
        -- vim.keymap.set("n", "[e", function()
        --     trouble.previous({ skip_groups = true, jump = true })
        -- end)

        -- #lsp-keymap
        -- vim.keymap.set("n", "<leader>wd", function()
        --     trouble.toggle("diagnostics")
        -- end)
    end,
}
