-- load basic plugin without custom config here
return {
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "tpope/vim-repeat",
    "wellle/targets.vim",
    "tpope/vim-fugitive",
    "sindrets/diffview.nvim",
    "romainl/vim-cool",
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
        "nvim-treesitter/playground",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
