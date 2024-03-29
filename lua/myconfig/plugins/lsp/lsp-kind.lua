return {
    "onsails/lspkind.nvim",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        cmp.setup({
            formatting = {
                expandable_indicator = true,
                fields = { "abbr", "menu", "kind" },
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    -- can also be a function to dynamically calculate max width such as
                    -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                }),
            },
        })
    end,
}
