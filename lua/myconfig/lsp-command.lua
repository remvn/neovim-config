local M = {}
local METHOD = "workspace/executeCommand"

local ts_util = {}
function ts_util.organize_imports(bufnr)
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
        title = "",
    }
    -- vim.lsp.buf.execute_command(params)
    vim.lsp.buf_request_sync(bufnr, METHOD, params, 500)
    vim.cmd(":w")
end

function M.register_lsp_cmd(client, bufnr)
    if client.name == "ts_ls" then
        vim.api.nvim_create_user_command("OrganizeImports", function()
            ts_util.organize_imports(bufnr)
        end, { desc = "Organize Imports" })
    end
end

return M
