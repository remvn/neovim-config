---@diagnostic disable: missing-fields

--- return true if `pwd` has a package.json that contains **vue** or **nuxt** dependency
--- @return boolean
local function setupVolar()
    -- https://theosteiner.de/using-volars-takeover-mode-in-neovims-native-lsp-client
    -- use neoconf to enable volar & disable tsserver
    local lspconfig = require("lspconfig")
    local json = require("neoconf.json")

    local f = io.open("package.json", "r")
    if not f then
        return false
    end

    local lines = f:read("*a")
    local obj = json.decode(lines)
    if obj == nil or obj.dependencies == nil or not json.isObject(obj.dependencies) then
        return false
    end

    local dependencies = obj.dependencies
    local isVueProject = false
    if dependencies.vue ~= nil or dependencies.nuxt ~= nil then
        isVueProject = true
    end

    if isVueProject == true then
        lspconfig.volar.setup({
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        })
    end

    f:close()
    return isVueProject
end

local function setupVolar2()
    local mason_registry = require("mason-registry")
    local lspconfig = require("lspconfig")

    -- volar
    lspconfig.volar.setup({
        init_options = {
            vue = {
                hybridMode = true,
            },
        },
    })

    -- tsserver
    ---@type lspconfig.options.tsserver
    local ts_options = {}

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

        ---@type lspconfig.options.tsserver
        local options = {
            filetypes = tsserverFiletypes,
            init_options = {
                plugins = { vue_plugin },
            },
        }
        ts_options = vim.tbl_deep_extend("force", ts_options, options)
    end

    lspconfig.tsserver.setup(ts_options)
end

local plugin = {
    "williamboman/mason.nvim",
    dependencies = {
        "VonHeikemen/lsp-zero.nvim",
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "b0o/schemastore.nvim",
        "folke/neoconf.nvim",
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
            jsonls = lsp_zero.noop,
            volar = lsp_zero.noop,
            tsserver = lsp_zero.noop,
            markdown_oxide = lsp_zero.noop,
            tailwindcss = lsp_zero.noop,
        })

        -- markdown_oxide
        local capabilities = require("cmp_nvim_lsp").default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
        capabilities.workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        }
        lspconfig.markdown_oxide.setup({
            -- again, ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
            capabilities = capabilities,
        })

        -- volar 1.x
        -- local hasVolar = setupVolar()
        -- if hasVolar == false then
        --     lspconfig.tsserver.setup({})
        -- end

        -- volar 2.x
        setupVolar2()

        lspconfig.tailwindcss.setup({
            settings = {
                tailwindCSS = {
                    classAttributes = { "class", "className", "ngClass", "class:list", "ui" },
                },
            },
        })

        -- jsonls
        lspconfig.jsonls.setup({
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })
    end,
}

return plugin
