---@diagnostic disable: redundant-return-value, missing-return-value
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
        local conform = require("conform")
        local prettier_pack = { "prettier" }
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = prettier_pack,
                typescript = prettier_pack,
                vue = prettier_pack,
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
    end,
}
