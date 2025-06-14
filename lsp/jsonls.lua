---@diagnostic disable: missing-fields, inject-field

---@type vim.lsp.ClientConfig
return {
    before_init = function(_, config)
        config.settings = vim.tbl_deep_extend("force", config.settings, {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        })
    end,
}

-- vim.lsp.config("jsonls", {
--     settings = {
--         json = {
--             schemas = require("schemastore").json.schemas(),
--             validate = { enable = true },
--         },
--     },
-- })
