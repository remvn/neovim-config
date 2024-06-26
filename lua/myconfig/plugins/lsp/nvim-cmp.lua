return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "VonHeikemen/lsp-zero.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local luasnip = require("luasnip")

        -- local lsp_zero = require("lsp-zero")
        -- lsp_zero.extend_cmp({
        --     set_mappings = false,
        --     set_lsp_source = false,
        --     use_luasnip = false, -- expand luasnip
        -- })

        local cmp = require("cmp")
        cmp.setup({
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
                {
                    name = "nvim_lsp",
                    option = {
                        markdown_oxide = {
                            keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
                        },
                    },
                },
                { name = "luasnip", keyword_length = 1 },
                { name = "path" },
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
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

                -- Supertab snippet
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
