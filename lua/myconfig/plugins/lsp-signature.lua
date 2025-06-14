return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
        require("lsp_signature").setup({
            bind = true,
            handler_opts = {
                border = "rounded",
            },
            -- workaround for this plugin
            -- keep overriding LspSignatureActiveParameter
            -- on lsp attach
            hi_parameter = "LspSignatureActiveFix",
            hint_enable = false,
        })
    end,
}
