local plugin = {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
    },
    config = function()
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local cmp = require("cmp")

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
                }),
            },

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.Item,
            completion = {
                -- some filetype do not preselect first item
                -- when using it without this option
                -- maybe this is caused by 'noselect' in default config
                completeopt = "menu,menuone",
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip", keyword_length = 1 },
                { name = "path" },
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered({ border = "rounded" }),
            },
            mapping = cmp.mapping.preset.insert({
                -- `Enter` key to confirm completion
                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                -- Ctrl+Space to trigger completion menu
                ["<C-Space>"] = cmp.mapping.complete(),

                ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                ["<C-j>"] = cmp.mapping.select_next_item({ behavior = "select" }),

                -- Scroll up and down in the completion documentation
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),

                -- Snippet jumping
                ["<C-l>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),

                ["<C-h>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            }),
        })
    end,
}

return plugin
