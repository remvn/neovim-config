---@diagnostic disable: missing-fields, inject-field

---@type vim.lsp.ClientConfig
return {
    settings = {
        yaml = {
            schemaStore = {
                enable = false,
                url = "",
            }
        }
    },
    before_init = function(_, config)
        -- can't assign new table because of
        -- https://github.com/neovim/neovim/issues/27740#issuecomment-1978629315
        config.settings.yaml.schemas = require("schemastore").yaml.schemas()
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
