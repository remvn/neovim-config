return {
    "williamboman/mason.nvim",
    dependencies = {
        "VonHeikemen/lsp-zero.nvim",
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    },
    lazy = false,
    config = function()
        local lsp_zero = require("lsp-zero")
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_registry = require("mason-registry")
        local mason_lsp = require("mason-lspconfig")

        mason.setup()
        mason_lsp.setup({
            ensure_installed = {
                "tsserver",
                "volar",
                "lua_ls",
                "gopls",
                "golangci_lint_ls",
                "bashls",
            },
            automatic_installation = true,
        })

        mason_lsp.setup_handlers({
            -- lsp-zero already handle these config below:
            -- * cmp-nvim-lsp capabilities
            -- * on_attach func
            -- see: lua/myconfig/plugins/lsp/lsp-config.lua
            -- therefore default_setup only call empty setup
            -- under the hood. (I guess)
            lsp_zero.default_setup,
            lua_ls = lsp_zero.noop,
            volar = lsp_zero.noop,
            tsserver = lsp_zero.noop,
        })

        -- config lua_ls for neovim
        local lua_opts = lsp_zero.nvim_lua_ls()
        lspconfig.lua_ls.setup(lua_opts)

        -- vue support for css and html
        ---@diagnostic disable-next-line: missing-fields
        lspconfig.volar.setup({
            init_options = {
                vue = {
                    hybridMode = true,
                },
            },
        })

        -- vue support through tsserver plugin
        local has_volar, volar = pcall(mason_registry.get_package, "vue-language-server")
        if has_volar then
            local vue_ls_path = volar:get_install_path() .. "/node_modules/@vue/language-server"
            local vue_plugin = {
                name = "@vue/typescript-plugin",
                location = vue_ls_path,
                languages = { "vue" },
            }

            local tsserverFiletypes = {
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
                "javascript.jsx",
                "typescript.tsx",
                "vue",
            }
            ---@diagnostic disable-next-line: missing-fields
            lspconfig.tsserver.setup({
                filetypes = tsserverFiletypes,
                init_options = {
                    plugins = {
                        vue_plugin,
                    },
                },
            })
        else
            ---@diagnostic disable-next-line: missing-fields
            lspconfig.tsserver.setup({})
        end
    end,
}
