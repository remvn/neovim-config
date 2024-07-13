local plugin = {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        local treesj = require("treesj")
        treesj.setup()

        vim.keymap.set("n", "<leader>jn", treesj.toggle)
    end,
}

return plugin
