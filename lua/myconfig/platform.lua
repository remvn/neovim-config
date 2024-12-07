local M = {}

-- sysname mapping
M.Windows = "Windows_NT"
M.Linux = "Linux"
M.MacOS = "Darwin"

function M:getSysName()
    ---@diagnostic disable-next-line: undefined-field
    return vim.uv.os_uname().sysname
end

function M:isWindows()
    local sysName = self:getSysName()
    return sysName == self.Windows
end

function M:isLinux()
    local sysName = self:getSysName()
    return sysName == self.Linux
end

function M:isMacOS()
    local sysName = self:getSysName()
    return sysName == self.MacOS
end

function M:isWSL()
    ---@diagnostic disable-next-line: undefined-field
    local uname = vim.uv.os_uname()
    local release = uname.release:lower()
    local isLinux = uname.sysname == self.Linux
    local hasMicrosoft = release:find("microsoft") ~= nil
    local hasWSL2 = release:find("wsl2") ~= nil

    return isLinux and hasMicrosoft and hasWSL2
end

return M
