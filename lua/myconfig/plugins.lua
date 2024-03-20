-- load basic plugin without custom config here
return {
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "wellle/targets.vim",
    "tpope/vim-fugitive",
    "sindrets/diffview.nvim",
    "romainl/vim-cool",
    {
        "nvim-treesitter/playground",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
