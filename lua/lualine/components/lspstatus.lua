local M = require('lualine.component'):extend()

local modules = require('lualine_require').lazy_require {
    highlight = 'lualine.highlight',
    utils = 'lualine.utils.utils',
}

M.init = function(self, options)
    if not options.icon then
        options.icon = "󰌘"
    end
    options.split = options.split or ", "
    M.super.init(self, options)
end

M.update_status = function(self)
    local buf_clients = vim.lsp.buf_get_clients()
    local null_ls_installed, null_ls = pcall(require, "null-ls")
    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
        if client.name == "null-ls" then
            if null_ls_installed then
                for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
                    table.insert(buf_client_names, source.name)
                end
            end
        else
            table.insert(buf_client_names, client.name)
        end
    end
    return table.concat(buf_client_names, self.options.split)
end

return M
