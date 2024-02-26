local plugin = {
    "ray-x/go.nvim",
    dependencies = {
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
        require("go").setup({
            disable_defaults = true,
            lsp_cfg = false,
            lsp_codelens = false,
            diagnostic = false,
            go = 'go',
            goimport = 'gopls',
            fillstruct = 'gopls',
            gofmt = 'gofumpt',
            tag_transform = 'snakecase',
            tag_options = '',
        })
    end,
}

return plugin
