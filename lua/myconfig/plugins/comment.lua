return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
        }
    },
    -- {
    --     'tpope/vim-commentary',
    --     dependencies = {
    --         'JoosepAlviste/nvim-ts-context-commentstring',
    --     },
    --     config = function()
    --         vim.g.skip_ts_context_commentstring_module = true
    --         require('ts_context_commentstring').setup()
    --         -- comment with Ctrl /
    --         vim.keymap.set("n", "<C-_>", "<Plug>ContextCommentaryLine")
    --         vim.keymap.set("v", "<C-_>", "<Plug>ContextCommentary")
    --     end
    -- },
    {
        'numToStr/Comment.nvim',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        lazy = false,
        config = function()
            vim.g.skip_ts_context_commentstring_module = true
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
            require('Comment').setup {
                mappings = {
                    basic = false,
                    extra = false,
                },
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
            local api = require('Comment.api')

            vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)
            vim.keymap.set('n', '<C-\\>', api.toggle.blockwise.current)

            local esc = vim.api.nvim_replace_termcodes(
                '<Esc>', true, false, true
            )

            vim.keymap.set('x', '<C-_>', function()
                vim.api.nvim_feedkeys(esc, 'nx', false)
                api.toggle.linewise(vim.fn.visualmode())
            end)
            vim.keymap.set('x', '<C-\\>', function()
                vim.api.nvim_feedkeys(esc, 'nx', false)
                api.toggle.blockwise(vim.fn.visualmode())
            end)
        end
    }
}
