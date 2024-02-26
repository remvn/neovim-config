-- load basic plugin without custom config here
return {
    'tpope/vim-surround',
    'wellle/targets.vim',
    -- 'tpope/vim-commentary',
    'tpope/vim-fugitive',
    'sindrets/diffview.nvim',
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
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                'javascript',
                'typescript',
                'vue',
                'css',
                'lua',
            })
        end,
    },
}
