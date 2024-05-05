return {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        local treesj = require("treesj")
        treesj.setup()

        -- For default preset
        vim.keymap.set("n", "<leader>jn", treesj.toggle)
    end,
}
