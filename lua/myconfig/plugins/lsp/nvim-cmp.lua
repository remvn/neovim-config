return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'VonHeikemen/lsp-zero.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        "hrsh7th/cmp-path",
    },
    config = function()
        local lsp_zero = require("lsp-zero")

        -- call cmp.setup with default
        -- mapping, sources, snippet
        -- FIXME: consider removing this later
        lsp_zero.extend_cmp({
            set_mappings = false,
            set_lsp_source = false,
            use_luasnip = true,
        })

        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()
        local cmp_format = require('lsp-zero').cmp_format()

        cmp.setup({
            preselect = cmp.PreselectMode.Item,
            completion = {
                -- some filetype do not preselect first item
                -- when using it without this option
                -- maybe this is caused by 'noselect' in default config
                completeopt = 'menu,menuone',
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "path" },
                { name = 'luasnip', keyword_length = 2 },
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = cmp_format,
            mapping = cmp.mapping.preset.insert({
                -- `Enter` key to confirm completion
                ['<CR>'] = cmp.mapping.confirm({ select = true }),

                -- Ctrl+Space to trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                -- Navigate between snippet placeholder
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                ['<C-j>'] = cmp.mapping.select_next_item({ behavior = 'select' }),

                -- Scroll up and down in the completion documentation
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
            }),
        })
    end
}
