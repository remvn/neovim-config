return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "VonHeikemen/lsp-zero.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        local luasnip = require("luasnip")

        -- call cmp.setup with default
        -- mapping, sources, snippet
        lsp_zero.extend_cmp({
            set_mappings = false,
            set_lsp_source = false,
            use_luasnip = true, -- expand luasnip
        })

        local cmp = require("cmp")
        local cmp_action = require("lsp-zero").cmp_action()
        local cmp_format = require("lsp-zero").cmp_format()

        cmp.setup({
            preselect = cmp.PreselectMode.Item,
            completion = {
                -- some filetype do not preselect first item
                -- when using it without this option
                -- maybe this is caused by 'noselect' in default config
                completeopt = "menu,menuone",
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "luasnip", keyword_length = 2 },
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            -- formatting = cmp_format,
            mapping = cmp.mapping.preset.insert({
                -- `Enter` key to confirm completion
                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                -- Ctrl+Space to trigger completion menu
                ["<C-Space>"] = cmp.mapping.complete(),

                -- Navigate between snippet placeholder
                ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                ["<C-b>"] = cmp_action.luasnip_jump_backward(),

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
