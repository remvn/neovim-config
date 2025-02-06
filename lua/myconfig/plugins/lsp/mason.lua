---@diagnostic disable: missing-fields

local function setupVolar2()
    local mason_registry = require("mason-registry")
    local lspconfig = require("lspconfig")

    local ts_options = {}

    -- add vue plugin
    local has_volar, volar = pcall(mason_registry.get_package, "vue-language-server")
    if has_volar then
        local vue_ls_path = volar:get_install_path() .. "/node_modules/@vue/language-server"
        local vue_plugin = {
            name = "@vue/typescript-plugin",
            location = vue_ls_path,
            languages = { "vue" },
        }

        local ts_ls_file_types = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "vue",
        }

        local options = {
            filetypes = ts_ls_file_types,
            init_options = {
                plugins = { vue_plugin },
            },
        }
        ts_options = vim.tbl_deep_extend("force", ts_options, options)
    end

    -- ts_ls
    lspconfig.ts_ls.setup(ts_options)

    -- volar
    lspconfig.volar.setup({})
end

local plugin = {
    "williamboman/mason.nvim",
    dependencies = {
        "VonHeikemen/lsp-zero.nvim",
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "b0o/schemastore.nvim",
    },
    lazy = false,
    config = function()
        local lsp_zero = require("lsp-zero")
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lsp = require("mason-lspconfig")

        mason.setup()
        mason_lsp.setup({
            ensure_installed = {
                "ts_ls",
                "volar",
                "lua_ls",
                "gopls",
                "golangci_lint_ls",
                "bashls",
                "jsonls",
                "yamlls",
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
            jsonls = lsp_zero.noop,
            yamlls = lsp_zero.noop,
            volar = lsp_zero.noop,
            ts_ls = lsp_zero.noop,
            tailwindcss = lsp_zero.noop,
            lua_ls = lsp_zero.noop,
        })

        -- volar 2.x
        setupVolar2()

        lspconfig.tailwindcss.setup({
            settings = {
                tailwindCSS = {
                    classAttributes = { "class", "className", "ngClass", "class:list", "ui" },
                },
            },
        })

        lspconfig.jsonls.setup({
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        lspconfig.yamlls.setup({
            settings = {
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    schemas = require("schemastore").yaml.schemas(),
                },
            },
        })

        lspconfig.lua_ls.setup({
            root_dir = lspconfig.util.root_pattern(
                ".luarc.json",
                ".luarc.jsonc",
                ".luacheckrc",
                ".stylua.toml",
                "stylua.toml",
                "selene.toml",
                "selene.yml",
                ".git"
            ),
        })
    end,
}

return plugin
