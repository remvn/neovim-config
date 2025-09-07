---@diagnostic disable: missing-fields
---@type vim.lsp.ClientConfig
return {
    settings = {
        tailwindCSS = {
            classFunctions = { "cva", "cx", "cn", "tv", "clsx" },
            experimental = {
                classRegex = {
                    { "clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
                },
            },
        },
    },
}
