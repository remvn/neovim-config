return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
        require "lsp_signature".setup({
            bind = true,
            handler_opts = {
                border = "rounded"
            },
            hint_enable = false
        })
        vim.keymap.set("n", "<leader>ls", function()
            require('lsp_signature').toggle_float_win()
        end)
    end,
}
