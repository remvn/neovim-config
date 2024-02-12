return {
    'williamboman/mason.nvim',
    dependencies = {
        'VonHeikemen/lsp-zero.nvim',
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
    },
    lazy = false,
    config = function()
        local lsp_zero = require("lsp-zero")

        require("mason").setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'tsserver', 'lua_ls', 'gopls', 'golangci_lint_ls', 'bashls'
            },
            automatic_installation = true,
            handlers = {
                -- lsp-zero already handle these config below:
                -- * cmp-nvim-lsp capabilities is set with hook
                -- * on_attach is set with LspAttach autocmd
                -- therefore default_setup only call empty setup
                -- under the hood.
                lsp_zero.default_setup,
                lua_ls = function()
                    -- config lua_ls for neovim
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            },
        })
    end,
}
