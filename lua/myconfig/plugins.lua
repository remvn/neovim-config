-- load basic plugin without custom config here
return {
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "wellle/targets.vim",
    "romainl/vim-cool",
    {
        dir = vim.fn.stdpath("config") .. "/lua/vendor/copy-reference",
        name = "copy-reference",
        config = function()
            require("vendor.copy-reference").setup({
                use_mention_format = true,
            })
        end,
    },
    -- {
    --     "andymass/vim-matchup",
    --     init = function()
    --         vim.g.matchup_treesitter_disable_virtual_text = true
    --         vim.g.matchup_matchparen_offscreen = {}
    --     end,
    -- },
}
