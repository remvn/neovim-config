local function isVimConfig()
    local f = io.open("NVIM_CONFIG", "r")
    if not f then
        return false
    end
    f:close()
    return true
end

return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        enabled = isVimConfig,
    },
}
