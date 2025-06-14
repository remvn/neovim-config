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

    -- vue_ls
    lspconfig.vue_ls.setup({})
end

return {}
