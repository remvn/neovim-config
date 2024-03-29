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
            "folke/neoconf.nvim",
        },
        config = function()
            require("neoconf").setup({})
            require("neodev").setup({})

            -- plugin init func create a LspAttach autocmd to
            -- call on_attach func
            local lsp_zero = require("lsp-zero")

            -- set cmp-nvim-lsp capabilities with lspconfig hook
            lsp_zero.extend_lspconfig()

            vim.g.lsp_zero_ui_float_border = "solid"
            vim.g.lsp_zero_ui_signcolumn = 1
            lsp_zero.set_sign_icons({
                -- error = "", warn = "", hint = "", info = "",
                error = "E",
                warn = "W",
                hint = "H",
                info = "I",
            })

            local servers = {
                ["null-ls"] = {
                    "javascript",
                    "typescript",
                    "json",
                    "jsonc",
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

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gH", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
            end)
        end,
    },
}
