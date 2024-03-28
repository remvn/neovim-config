local M = {}
local METHOD = "workspace/executeCommand"

local tsserver = {}
function tsserver.organize_imports(bufnr)
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
        title = "",
    }
    -- vim.lsp.buf.execute_command(params)
    vim.lsp.buf_request_sync(bufnr, METHOD, params, 500)
    vim.cmd(":w")
end

function M.register_tsserver_cmd(client, bufnr)
    if client.name == "tsserver" then
        vim.api.nvim_create_user_command("OrganizeImports", function()
            tsserver.organize_imports(bufnr)
        end, { desc = "Organize Imports" })
    end
end

return M
