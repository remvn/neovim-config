---@diagnostic disable: missing-fields
local vue_language_server_path = vim.fn.expand("$MASON/packages")
    .. "/vue-language-server"
    .. "/node_modules/@vue/language-server"
local vue_plugin = {
    name = "@vue/typescript-plugin",
    location = vue_language_server_path,
    languages = { "vue" },
    configNamespace = "typescript",
}

local function organize_imports()
    vim.lsp.buf.code_action({
        apply = true,
        context = {
            only = { "source.organizeImports.ts", "source.organizeImports" },
        },
    })
end

---@type vim.lsp.ClientConfig
return {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    on_attach = function(_, bufnr)
        vim.keymap.set(
            "n",
            "<leader>oi",
            organize_imports,
            { buffer = bufnr, desc = "Organize Imports" }
        )
        vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", organize_imports, {
            desc = "Organize Imports",
        })
    end,
}
