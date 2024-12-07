local M = {}

function M:getSysName()
    ---@diagnostic disable-next-line: undefined-field
    return vim.uv.os_uname().sysname
end

return M
