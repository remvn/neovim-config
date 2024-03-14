-- load order:
-- lsp-zero utils
-- nvim-lspconfig & cmp
-- mason (config lsp servers with mason)

return {
    -- lsp utils functions
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        config = false,
        lazy = true,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "VonHeikemen/lsp-zero.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "folke/neodev.nvim",
        },
        config = function()
            require("neodev").setup({})

            -- plugin init func create a LspAttach autocmd to
            -- call on_attach func
            local lsp_zero = require("lsp-zero")

            -- set cmp-nvim-lsp capabilities with lspconfig hook
            lsp_zero.extend_lspconfig()

            vim.g.lsp_zero_ui_float_border = "solid"
            vim.g.lsp_zero_ui_signcolumn = 1
            lsp_zero.set_sign_icons({
                error = "E",
                warn = "W",
                hint = "H",
                info = "I",
                -- error = "",
                -- warn = "",
                -- hint = "",
                -- info = "",
            })

            local servers = {
                ["null-ls"] = {
                    "javascript",
                    "typescript",
                    "json",
                    "yaml",
                    "yml",
                    "vue",
                    "lua",
                },
                ["rust_analyzer"] = { "rust" },
                ["gopls"] = { "go" },
                -- ["lua_ls"] = { "lua" },
            }
            lsp_zero.format_on_save({ servers = servers })
            lsp_zero.format_mapping("<leader>f", { servers = servers })

            lsp_zero.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set("n", "gh", function()
                    vim.lsp.buf.hover()
                end, opts)
                vim.keymap.set("n", "gH", function()
                    vim.lsp.buf.references()
                end, opts)
                vim.keymap.set("n", "gi", function()
                    vim.lsp.buf.implementation()
                end, opts)
                vim.keymap.set("n", "<leader>ws", function()
                    vim.lsp.buf.workspace_symbol()
                end, opts)
                vim.keymap.set("n", "<leader>ca", function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set("n", "<leader>r", function()
                    vim.lsp.buf.rename()
                end, opts)

                vim.keymap.set("n", "<leader>of", function()
                    vim.diagnostic.open_float()
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, opts)
                vim.keymap.set("i", "<C-k>", function()
                    vim.lsp.buf.signature_help()
                end, opts)
            end)
        end,
    },
}
