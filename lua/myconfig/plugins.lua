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
    --     "olimorris/onedarkpro.nvim",
    --     priority = 1000,
    --     config = function()
    --         vim.cmd("colorscheme onedark")
    --     end,
    -- },
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
    "sindrets/diffview.nvim",
    'nvim-lua/lsp-status.nvim',

    -- utility
    'tpope/vim-surround',
    'wellle/targets.vim',
    'tpope/vim-commentary',
    'tpope/vim-fugitive',
    'romainl/vim-cool',
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require("nvim-autopairs").setup {} end,
    },
    {
        'nvim-treesitter/playground',
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
}
