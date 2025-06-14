---@diagnostic disable: missing-fields, inject-field

---@type vim.lsp.ClientConfig
return {
    before_init = function(_, config)
        config.settings = vim.tbl_deep_extend("force", config.settings, {
            yaml = {
                schemaStore = {
                    enable = false,
                    url = "",
                },
                schemas = require("schemastore").yaml.schemas(),
            },
        })
    end,
}

-- vim.lsp.config("yamlls", {
--     settings = {
--         yaml = {
--             schemaStore = {
--                 enable = false,
--                 url = "",
--             },
--             schemas = require("schemastore").yaml.schemas(),
--         },
--     },
-- })
