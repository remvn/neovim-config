return {
    "gbprod/substitute.nvim",
    config = function()
        local substitute = require("substitute")
        substitute.setup({
            highlight_substituted_text = {
                enabled = true,
                timer = 500,
            },
        })

        vim.keymap.set("n", "s", substitute.operator, { noremap = true })
        vim.keymap.set("n", "ss", substitute.line, { noremap = true })
        vim.keymap.set("x", "s", substitute.visual, { noremap = true })
    end,
}
