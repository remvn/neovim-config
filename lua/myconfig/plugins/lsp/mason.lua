local plugin = {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-org/mason.nvim",
        "b0o/schemastore.nvim",
        "hrsh7th/nvim-cmp",
    },
    lazy = false,
    config = function()
        local mason = require("mason")
        local mason_lspconf = require("mason-lspconfig")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my.lsp", {}),
            callback = function(args)
                local opts = { buffer = args.buf, remap = false }
                local windowOptions = { border = "rounded" }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gH", vim.lsp.buf.references, opts)
                -- references see: plugins/telescope.lua
                vim.keymap.set("n", "gh", function()
                    vim.lsp.buf.hover(windowOptions)
                end, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, opts)
                vim.keymap.set("i", "<C-k>", function()
                    vim.lsp.buf.signature_help(windowOptions)
                end, opts)
            end,
        })

        -- local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- vim.tbl_deep_extend("force", capabilities, cmp_nvim.default_capabilities())
        local cmp_nvim = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim.default_capabilities()
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        -- TODO lua_ls missing .git root_markers

        mason.setup()
        mason_lspconf.setup({
            ensure_installed = {
                "ts_ls",
                "vue_ls",
                "lua_ls",
                "gopls",
                "golangci_lint_ls",
                "bashls",
                "jsonls",
                "yamlls",
            },
            automatic_enable = true,
        })
    end,
}

return plugin
