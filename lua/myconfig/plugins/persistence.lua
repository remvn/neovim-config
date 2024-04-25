return {
    "folke/persistence.nvim",
    -- event = "BufReadPre",
    config = function()
        local persistence = require("persistence")
        persistence.setup()

        vim.keymap.set("n", "<leader>qs", function()
            persistence.load()
        end)
    end,
}
