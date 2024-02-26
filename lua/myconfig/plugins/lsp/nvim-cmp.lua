local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local function tabout()
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    local arr = { [["]], [[']], "`", ")", "]", "}" }
    local right = vim.api.nvim_replace_termcodes(
        '<right>', true, false, true
    )
    if has_value(arr, char) then
        vim.api.nvim_feedkeys(right, "i", true)
        return true
    end
    return false
end

return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'VonHeikemen/lsp-zero.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
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
            -- formatting = cmp_format,
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

                -- Supertab snippet
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        if tabout() == false then
                            fallback()
                        end
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
        })
    end
}
