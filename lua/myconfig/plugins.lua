-- load basic plugin without custom config here
return {
    {
        "briones-gabriel/darcula-solid.nvim",
        dependencies = "rktjmp/lush.nvim",
        priority = 1000,
        init = function()
            vim.cmd.colorscheme("darcula-solid")
            vim.opt.termguicolors = true
        end,
    },

    -- utility
    'tpope/vim-surround',
    'wellle/targets.vim',
    'tpope/vim-commentary',
    'tpope/vim-fugitive',
    'romainl/vim-cool',
    -- {
    --     "windwp/nvim-autopairs",
    --     event = "InsertEnter",
    --     config = function() require("nvim-autopairs").setup {} end,
    -- },
}
