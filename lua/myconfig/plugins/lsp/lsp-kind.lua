return {
    'onsails/lspkind.nvim',
    dependencies = {
        'hrsh7th/nvim-cmp',
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')

        cmp.setup {
            formatting = {
                fields = { 'abbr', 'menu', 'kind' },
                format = lspkind.cmp_format({
                    preset = 'codicons',
                    mode = 'symbol_text', -- show only symbol annotations
                    maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    -- can also be a function to dynamically calculate max width such as
                    -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function(entry, vim_item)
                        vim_item.menu = '     '
                        return vim_item
                    end
                })
            }
        }
    end
}