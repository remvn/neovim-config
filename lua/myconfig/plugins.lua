-- load basic plugin without custom config here
return {
    {
        "briones-gabriel/darcula-solid.nvim",
        dependencies = "rktjmp/lush.nvim",
        priority = 1000,
        init = function()
            vim.cmd.colorscheme("darcula-custom")
        end,
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         require("tokyonight").setup({
    --             style = "moon",
    --             transparent = false,
    --         })
    --         vim.cmd("colorscheme tokyonight-moon")
    --     end,
    -- },

    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        config = function()
            require "lsp_signature".setup({
                bind = true,
                handler_opts = {
                    border = "rounded"
                },
                hint_enable = false
            })
            vim.keymap.set("n", "<leader>ls", function()
                require('lsp_signature').toggle_float_win()
            end)
        end,
    },

    -- utility
    'tpope/vim-surround',
    'wellle/targets.vim',
    'tpope/vim-commentary',
    'tpope/vim-fugitive',
    "sindrets/diffview.nvim",
    'romainl/vim-cool',
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "windwp/nvim-ts-autotag",
        config = true,
    },
    {
        'nvim-treesitter/playground',
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
}
